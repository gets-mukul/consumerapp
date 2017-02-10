class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  PAYU_IN_PAYMENT_URL = Rails.application.secrets.PAYMENT_URL

  include PaymentHelper
  before_action :check_current_user
  after_action :update_payment, only: [:success, :failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure]

  # def index
  #   @error_msg = ""
  #   unless params[:age].to_i.between?(3,65) && ( params[:skincancer] == 'No' || params[:skincancer].blank? ) && !red_flags
  #       @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
  #       failure
  #   end
  # end
  
  def index
    @error_msg = ""
    unless !params[:city].blank?
        @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
        failure
    end
  end

  def issue_payment
    mode = "pending"
    payment_params = build_payment_params

    current_user.payments.create(user_payment_params(payment_params, mode))

    url = URI.parse(PAYU_IN_PAYMENT_URL)
    con = Net::HTTP.new(url.host, url.port )
    con.use_ssl = true
    resp, data = con.post url.path, payment_params.to_query, 'Content-Type' => 'application/json'

    case resp
    when Net::HTTPRedirection then
      location = resp['location']
      warn "redirected to #{location}"
      redirect_to URI.parse(location).to_s
    else
      @error_msg = 'Error at Payment Gateway!'
      failure
      logger.info resp.body.strip
    end

  end

  def success
    posted_hash = params["hash"]

    checksum_hash = checksum(params, current_payment)
    @patient = Patient.find_by_name current_user.name

    if checksum_hash != posted_hash
      @error_msg = "Invalid Checksum!"
      @patient.update({pay_status: "payment failed|invalid checksum"})
      failure
    else
      @patient.update({pay_status: "paid"})
      CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      render 'success'
    end
  end

  def failure
    @patient = Patient.find_by_name current_user.name
    @error_msg ||= params['error_Message'] + "|" + params['unmappedstatus']
    @patient.update({pay_status: "payment failed : #{@error_msg}"})
    render 'failure'
    if request.method == "GET"
      # Redirection from within controller
      unregister
    end
  end

  private

  def current_payment
    current_user.payments.find_by_txnid(session[:txnid])
  end

  def update_payment
    current_payment.update(capture_params)
    unregister
  end

end

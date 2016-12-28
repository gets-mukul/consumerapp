class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  PAYU_IN_PAYMENT_URL = Rails.application.secrets.PAYMENT_URL

  include PaymentHelper
  before_action :check_current_user
  after_action :update_payment, only: [:success, :failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure]

  def index
  end

  def issue_payment
    mode = case params[:type]
    when "CREDIT CARD" then "credit"
    when "DEBIT CARD" then "debit"
    when "NET BANKING" then "netbanking"
    end

    payment_params = build_payment_params mode

    current_user.payments.create(user_payment_params(payment_params))

    url = URI.parse(PAYU_IN_PAYMENT_URL)
    con = Net::HTTP.new(url.host, url.port)
    con.use_ssl = true
    resp, data = con.post url.path, payment_params.to_query

    location = resp['location']
    redirect_to URI.parse(location).to_s + "##{mode}"

  end

  def success
    posted_hash = params["hash"]

    checksum_hash = checksum(params, current_payment)
    @patient = Patient.find_by_name current_user.name

    if checksum_hash != posted_hash
      @error = "Invalid Checksum!"
      @patient.update({pay_status: "payment failed"})
      render 'failure'
    else
      @patient.update({pay_status: "paid"})
      UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      render 'success'
    end
  end

  def failure
    @patient = Patient.find_by_name current_user.name
    @patient.update({pay_status: "payment failed"})
    @error = params['error_Message']
    render 'failure'
  end

  private

  def check_current_user
    unless current_user
      redirect_to '/new_patient'
    end
  end

  def update_payment
    current_payment.update(capture_params)
  end

  def current_payment
    current_user.payments.find_by_txnid(session[:txnid])
  end

  def user_payment_params payment_params
    {
      :txnid => payment_params[:txnid],
      :status => "Initiated",
      :amount	=> payment_params[:amount],
      :mode => payment_params[:mode],
      :desc	=> payment_params[:productinfo]
    }
  end

  def capture_params
    mihpayid = params["mihpayid"] #	Unique reference no. created at PayUbiz’s end for each transaction.
    mode	= params["mode"]        # Payment category by which the transaction was completed/ attempted.
    pg_type = params["PG_TYPE"]	  # Gives the information of payment gateway used for transaction.
    bank_ref_num = params["bank_ref_num"]	# For a successful transaction, this will give you the bank reference number generated at bank’s end.
    { mihpayid: mihpayid, mode: mode, pg_type: pg_type, bank_ref_num: bank_ref_num }
  end
end

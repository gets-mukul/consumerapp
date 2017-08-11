class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  PAYU_IN_PAYMENT_URL = Rails.application.secrets.PAYMENT_URL
  PAYTM_MERCHANT_KEY = Rails.application.secrets.PAYTM_MERCHANT_KEY
  PAYTM_INITIAL_TRASACTION_URL = Rails.application.secrets.PAYTM_INITIAL_TRASACTION_URL

  include PaymentHelper
  include PaytmHelper
  before_action :check_current_user
  after_action :update_payment, only: [:failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure]

  # def index
  #   @error_msg = ""
  #   unless params[:age].to_i.between?(3,65) && ( params[:skincancer] == 'No' || params[:skincancer].blank? ) && !red_flags
  #       @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
  #       failure
  #   end
  # end

  def index
    logger.info 'SESSION'
    logger.info session[:promo_code]

    @error_msg = ""
    unless !params[:city].blank?
        @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
        failure
    end

    @amount = 350
    if session[:promo_code]
      if ['SOCIAL150', 'REFER150'].include? session[:promo_code]
        @amount = 200
      else
        @coupon = Coupon.find_by coupon_code: session[:promo_code]
        @coupon.increment!(:count, 1)
        if @coupon.count >= @coupon.max_count
          @coupon.update(status: 'coupon used')
        end
        @amount = @amount - @coupon.discount_amount
      end
    end


    # if session[:promo_code] and session[:promo_code].starts_with? "SODELHI"
    #   @coupon = Coupon.find_by coupon_code: session[:promo_code]
    #   @coupon.increment!(:count, 1)
    #   @coupon.update(status: 'coupon used')
    # end
    # @amount = 350
    # # if session[:coupon_applied]
    # #   @amount = 200
    # # end
    # if ['SOCIAL150', 'REFER150'].include? session[:promo_code]
    #   @amount = 200
    # end
    # @error_msg = ""
    # unless !params[:city].blank?
    #     @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
    #     failure
    # end
  end

  def issue_payment
    mode = "pending"
    payment_params = build_paytm_params
    checksum_hash = new_pg_checksum(payment_params, PAYTM_MERCHANT_KEY).gsub("\n",'')
    current_user.payments.create(user_payment_params(payment_params, mode, "PAYTM"))
    @content_paytm = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=ISO-8859-I\"><title>Paytm</title></head><body><center><h2>Redirecting to Paytm </h2><br /><h1>Please do not refresh this page...</h1></center><form method=\"post\" action=\"#{PAYTM_INITIAL_TRASACTION_URL}\" name=\"f1\">"
      keys = payment_params.keys
      keys.each do |k|
        @content_paytm +=  "<input type=\"hidden\" name=\"#{k}\" value=\"#{payment_params[k]}\">"
      end
    @content_paytm = @content_paytm + "<input type=\"hidden\" name=\"CHECKSUMHASH\" value=\"#{checksum_hash}\"></form><script type=\"text/javascript\">document.f1.submit();</script></body></html>"
    logger.info "patient: #{current_user.name} redirected to paytm"
    return render html: @content_paytm.html_safe
  end

  def success
    logger.info params
    posted_hash = params["hash"]
    paytm_params = Hash.new
    params.keys.each do |k|
      unless ["CHECKSUMHASH", "action", "controller"].include? k
        paytm_params[k] = params[k]
      end
    end

    checksum_hash = params["CHECKSUMHASH"]
    @patient = Patient.find_by_id current_user.id
    if params["STATUS"] == "TXN_FAILURE"
      @error_msg = "#{@patient.name} has cancelled the payment"
      logger.error "looks like #{@patient.name} has cancelled the payment"
      @patient.update({pay_status: "payment cancelled by patient"})
	  current_payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: params['BANKTXNID']})
      ErrorEmailer.error_email(@error_msg).deliver
      failure
    elsif not new_pg_verify_checksum(paytm_params, checksum_hash, PAYTM_MERCHANT_KEY)
      @error_msg = "Invalid Checksum!"
      logger.error "invalid checksum for #{@patient.name}"
      @patient.update({pay_status: "payment failed|invalid checksum"})
      ErrorEmailer.error_email("invalid checksum for " + @patient.name).deliver
      failure
    else
      url = URI.parse("https://secure.paytm.in/oltp/HANDLER_INTERNAL/getTxnStatus")
      con = Net::HTTP.new(url.host, url.port )
      con.use_ssl = true
      request_data = {"MID": params["MID"], "ORDERID": params["ORDERID"]}
      new_checksum_hash = new_pg_checksum(request_data, PAYTM_MERCHANT_KEY).gsub("\n",'')
      request_data["CHECKSUMHASH"] = new_checksum_hash
      resp, data = con.get url.path + "?JsonData=" + request_data.to_json
      logger.info resp.body
      # case resp
      # when Net::HTTPRedirection then
      #   location = resp['location']
      #   warn "redirected to #{location}"
      #   redirect_to URI.parse(location).to_s
      # else
      #   @error_msg = 'Error at Payment Gateway!'
      #   failure
      #   logger.info resp.body.strip
      # end
      @patient.update({pay_status: "paid"})
	  current_payment.update({mode: params['PAYMENTMODE'], status: 'paid', bank_ref_num: params['BANKTXNID']})
      CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      render 'success'
	  unregister
    end
  end

  def failure
    logger.error "payment failure for patient: #{current_user.name}"
    @patient = Patient.find_by_id current_user.id
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

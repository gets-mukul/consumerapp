class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  PAYU_IN_PAYMENT_URL = Rails.application.secrets.PAYMENT_URL
  PAYTM_MERCHANT_KEY = Rails.application.secrets.PAYTM_MERCHANT_KEY
  PAYTM_INITIAL_TRASACTION_URL = Rails.application.secrets.PAYTM_INITIAL_TRASACTION_URL

  include PaymentHelper
  include PaytmHelper
  before_action :check_current_user, :check_current_consultation
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

    logger.info "CURRENT CONSULTATION"
    logger.info @current_consultation
    logger.info current_consultation

    typeform_uid = session[:typeform_uid]
    response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
    @error_msg = ""
    unless !params[:city].blank?
        @error_msg = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
        failure
        return
    end
    
    # get email of the current user from typeform responses
    begin
      typeform_uid = session[:typeform_uid]
      if typeform_uid
        response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
        response = JSON.parse(response.body)
        responses = response["responses"]
        mobile_nos = responses.collect { |x| x["hidden"]["mobile"] }
        idx = mobile_nos.index(current_user.mobile)
        mail = responses[idx]["answers"]["email_58205238"] || responses[idx]["answers"]["email_58205344"] || responses[idx]["answers"]["email_58205331"] || responses[idx]["answers"]["email_58205400"] || responses[idx]["answers"]["email_58205374"] || responses[idx]["answers"]["email_58205430"] || ""
        if !mail.empty?
          current_user.update(email: mail)
        end
      end
    rescue
    end
    
    current_consultation.update(user_status: 'form filled')

    @amount = current_consultation.amount

    if @amount == 0
      success_without_payment
    end
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

  def success_without_payment
    session[:promo_code] = ""
    logger.info "SUCCESS WITHOUT PAYMENT"
    render 'success_without_payment'
    UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if current_user.email.present? and Rails.env.production?
    
    current_user.update({pay_status: "free"})
    current_consultation.update({pay_status: "free", user_status: 'free consultation done'})
    unregister_consultation
    unregister
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
    if params["STATUS"] == "TXN_FAILURE"
      @error_msg = "#{current_user.name} has cancelled the payment"
      logger.error "looks like #{current_user.name} has cancelled the payment"
      current_user.update({pay_status: "payment cancelled by patient"})
      current_consultation.update({ pay_status: "payment cancelled by patient", user_status: 'payment failed' })
      current_payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: params['BANKTXNID']})
      ErrorEmailer.error_email(@error_msg).deliver
      failure
    elsif not new_pg_verify_checksum(paytm_params, checksum_hash, PAYTM_MERCHANT_KEY)
      @error_msg = "Invalid Checksum!"
      logger.error "invalid checksum for #{current_user.name}"
      current_user.update({pay_status: "payment failed|invalid checksum"})
      current_consultation.update({ pay_status: "payment failed|invalid checksum", user_status: 'payment failed' })
      ErrorEmailer.error_email("invalid checksum for " + current_user.name).deliver
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
      current_user.update({pay_status: "paid"})
      current_consultation.update({ pay_status: "paid", user_status: 'paid' })

      UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if current_user.email.present? and Rails.env.production?
      current_payment.update({mode: params['PAYMENTMODE'], status: 'paid', bank_ref_num: params['BANKTXNID']})
      CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      # UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
      render 'success'
      unregister_consultation
      unregister
    end
  end

  def failure
    logger.error "payment failure for patient: #{current_user.name}"
    @error_msg ||= params['error_Message'] + "|" + params['unmappedstatus']
    current_user.update({pay_status: "payment failed : #{@error_msg}"})
    current_consultation.update({ pay_status: "payment failed : #{@error_msg}", user_status: 'payment failed' })
    render 'failure'
    if request.method == "GET"
      # Redirection from within controller
      unregister_consultation
      unregister
    end
  end

  private

  def current_payment
    current_user.payments.find_by_txnid(session[:txnid])
  end

  def update_payment
    current_payment.update(capture_params)
    unregister_consultation
    unregister
  end

end

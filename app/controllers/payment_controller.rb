class PaymentController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  require 'encrypt'
  require 'razorpay'
  PAYU_IN_PAYMENT_URL = Rails.application.secrets.PAYMENT_URL
  PAYTM_MERCHANT_KEY = Rails.application.secrets.PAYTM_MERCHANT_KEY
  PAYTM_INITIAL_TRASACTION_URL = Rails.application.secrets.PAYTM_INITIAL_TRASACTION_URL

  include PaymentHelper
  include PaytmHelper
  before_action :check_current_user, :check_current_consultation, except: [:instant_payment]
  after_action :update_payment, only: [:failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure]

  def index
    logger.info "IN INDEX"
    logger.info current_consultation.id
    typeform_uid = session[:typeform_uid]
    # response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
    session[:error_msg] = ""
    if params[:city].blank?
      logger.info "FAILED"
        session[:error_msg] = 'Sorry, but we cannot treat your ailment. Please schedule an appointment at a nearby hospital.'
        logger.info "ERROR MSG"
        logger.info session[:error_msg]
        redirect_to :failure
        # failure
    else
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
        redirect_to :success_free
      end
    end
  end

  def issue_payment_paytm
    logger.info "ISSUE PAYMENT PAYTM"
    logger.info params

    payment_params = build_paytm_params
    checksum_hash = new_pg_checksum(payment_params, PAYTM_MERCHANT_KEY).gsub("\n",'')
    current_payment.update(user_payment_params(payment_params, "pending", "PAYTM"))
    @content_paytm = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=ISO-8859-I\"><title>Paytm</title></head><body><center><h2>Redirecting to Paytm </h2><br /><h1>Please do not refresh this page...</h1></center><form method=\"post\" action=\"#{PAYTM_INITIAL_TRASACTION_URL}\" name=\"f1\">"
      keys = payment_params.keys
      keys.each do |k|
        @content_paytm +=  "<input type=\"hidden\" name=\"#{k}\" value=\"#{payment_params[k]}\">"
      end
    @content_paytm = @content_paytm + "<input type=\"hidden\" name=\"CHECKSUMHASH\" value=\"#{checksum_hash}\"></form><script type=\"text/javascript\">document.f1.submit();</script></body></html>"
    logger.info "patient: #{current_user.name} redirected to paytm"
    logger.info @content_paytm
    return render html: @content_paytm.html_safe
  end

  def initiate_payment
    logger.info "ISSUE PAYMENT"
    logger.info session[:txnid]
    if session[:txnid].blank?
      logger.info "YES TXNID BLANK"
      payment_params = { :txnid => build_transaction_id, :amount => current_consultation.amount.round(2) }
      current_user.payments.create(user_payment_params(payment_params, "pending", "RAZORPAY"))
    end
    render :json => { :value => "success" }
  end

  def success_free
    logger.info "SUCCESS WITHOUT PAYMENT"
    render 'success_free'
    UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if current_user.email.present? and Rails.env.production?
    SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
    FreeConsultationNotifierMailer.send_free_consultation_notifier_mail(current_consultation).deliver_later if Rails.env.production?
    current_user.update({pay_status: "free"})
    current_consultation.update({pay_status: "free", user_status: 'free consultation done'})
    coupon = Coupon.find_by_id current_consultation.coupon_id
    if coupon
      coupon.increment!(:count, 1)
      coupon.update(status: 'coupon used')
    end
    session[:promo_code] = ""
    unregister_consultation
    unregister
  end

  def success
    logger.info params
    if params[:pg_type]=="RAZORPAY"
      current_payment.update({:pg_type => "RAZORPAY"})
    end
    if current_payment.pg_type=='PAYTM'
      posted_hash = params["hash"]
      paytm_params = Hash.new
      params.keys.each do |k|
        unless ["CHECKSUMHASH", "action", "controller"].include? k
          paytm_params[k] = params[k]
        end
      end

      checksum_hash = params["CHECKSUMHASH"]
      if params["STATUS"] == "TXN_FAILURE"
        session[:error_msg] = "#{current_user.name} has cancelled the payment"
        logger.error "looks like #{current_user.name} has cancelled the payment"
        current_user.update({pay_status: "payment cancelled by patient"})
        current_consultation.update({ pay_status: "payment cancelled by patient", user_status: 'payment failed' })
        current_payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: params['BANKTXNID']})
        ErrorEmailer.error_email(session[:error_msg]).deliver
        redirect_to :failure
      elsif not new_pg_verify_checksum(paytm_params, checksum_hash, PAYTM_MERCHANT_KEY)
        session[:error_msg] = "Invalid Checksum!"
        logger.error "invalid checksum for #{current_user.name}"
        current_user.update({pay_status: "payment failed|invalid checksum"})
        current_consultation.update({ pay_status: "payment failed|invalid checksum", user_status: 'payment failed' })
        ErrorEmailer.error_email("invalid checksum for " + current_user.name).deliver
        redirect_to :failure
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
        #   session[:error_msg] = 'Error at Payment Gateway!'
        #   failure
        #   logger.info resp.body.strip
        # end
        current_user.update({pay_status: "paid"})
        current_consultation.update({ pay_status: "paid", user_status: 'paid' })

        UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if current_user.email.present? and Rails.env.production?
        SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
        current_payment.update({mode: params['PAYMENTMODE'], status: 'paid', bank_ref_num: params['BANKTXNID']})
        CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later
        
        coupon = Coupon.find_by_id current_consultation.coupon_id
        if coupon
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end
        render 'success'
        unregister_consultation
        unregister
      end
    elsif current_payment.pg_type=='RAZORPAY'

      logger.info "ISSUE PAYMENT RAZORPAY"
      logger.info params
      amount = current_consultation.amount*100
      response = Razorpay::Payment.fetch(params[:payment_id])
      if (response.status=='authorized')
        logger.info "CAPTURING PAYMENT"
        response = response.capture({amount:amount})
        current_payment.update({status: response.status, pg_type: 'RAZORPAY'})
      
        current_user.update({pay_status: "paid"})
        current_consultation.update({ pay_status: "paid", user_status: 'paid' })

        mode = case response.method
        when "netbanking"
          "netbanking - " + response.bank
        when  "wallet"
          "wallet - " + response.wallet
        else
          response.method
        end

        UserPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if current_user.email.present? and Rails.env.production?
        SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
        current_payment.update({mode: mode, status: 'paid', bank_ref_num: response.id})
        CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment).deliver_later if Rails.env.production?
        coupon = Coupon.find_by_id current_consultation.coupon_id
        if coupon
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end
        render 'success'
        unregister_consultation
        unregister
      elsif
        session[:error_msg] = "Authorization Error!"
        logger.info response
        ErrorEmailer.error_email("razorpay payment not authorized for " + current_user.name).deliver
        redirect_to :failure
      end
    end
      
  end

  def failure
    logger.info "IN FAILURE"
    logger.info "ERROR MSG"
    logger.info session[:error_msg]
    logger.error "payment failure for patient: #{current_user.name}"
    session[:error_msg] ||= params['error_Message'] + "|" + params['unmappedstatus']
    current_user.update({pay_status: "payment failed : #{session[:error_msg]}"})
    current_consultation.update({ pay_status: "payment failed : #{session[:error_msg]}", user_status: "payment failed : #{session[:error_msg]}" })
    render 'failure'
    # if request.method == "GET"
    #   Redirection from within controller
    #   unregister_consultation
    #   unregister
    # end
  end

  def instant_payment
    logger.info "INSTANT PAYMENT"
    id = decrypt(params[:p], 1)
    if id.nil?
      redirect_to "/"
    else
      @consultation = Consultation.find_by_id id
      if @consultation
        register_consultation @consultation
        register @consultation.patient
        return redirect_to "/consult/payment?city=null"
      else
        redirect_to "/"
      end
    end
  end

  private

  def current_payment
    current_user.payments.find_by_txnid(session[:txnid])
  end

  def update_payment
    logger.info "UPDATE PAYMENT"
    logger.info current_user.payments
    current_payment.update(capture_params) if !current_payment.nil?
    unregister_consultation
    unregister
  end

end

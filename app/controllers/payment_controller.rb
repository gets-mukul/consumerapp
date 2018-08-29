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
  # include DoctorHelper
  # before_action :check_current_user, :check_current_consultation, except: [:instant_payment]
  before_filter :check_if_reverse_flow, only: [:index]
  before_filter :check_current_user, :check_current_consultation, except: [:instant_payment, :new, :create]
  # before_action :fetch_matched_consultation_doctor, except: [:instant_payment]
  after_action :update_payment, only: [:failure]
  skip_before_action :verify_authenticity_token, only: [:success, :failure, :initiate_payment]

  def check_if_reverse_flow
    if session[:my_consultation_id]
      redirect_to '/my_consultation/success?age='+params[:age]+'&city='+params[:city]+'&sex='+params[:sex]+'&redflag='+params[:redflag]
      return
    end
  end

  def index
    Rails.logger.info("Payments Controller: Payments index");
    logger.info "Payment Controller: in payment index for #{current_consultation.id}"
    logger.info params
    if (params[:type])
      chatbot_handler
      return
    end
    session[:error_msg] = ""
    # Rails.logger.info 'Payments Controller: Request Referrer'
    # Rails.logger.info request.referer
    # if !request.referer.nil? and URI.parse(request.referer).path.start_with?("/consult/consultation_form", "/to/")
    unless params[:age].blank?
      current_user.age = params[:age] unless params[:age].blank?
      current_user.city = params[:city] unless params[:city].blank?
      current_user.sex = params[:sex] unless params[:sex].blank?
      current_user.save!
    end
    if params[:city].blank?
      session[:tmp_age] = nil
      unless params[:age].empty?
        session[:tmp_age] = params[:age] if !params[:age].to_i.between?(3, 65)
      end
      session[:tmp_red_flag] = params[:redflag].humanize.reverse.sub(','.reverse, ' and'.reverse).reverse

      redirect_to :flag
    else
      # get email of the current user from typeform responses and store it
      begin
        typeform_uid = session[:typeform_uid]
        if typeform_uid
          response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
          response = JSON.parse(response.body)
          responses = response["responses"]
          mobile_nos = responses.collect { |x| x["hidden"]["mobile"] }
          idx = mobile_nos.index(current_user.mobile)
          mail = responses[idx]["answers"]["email_58205238"] || responses[idx]["answers"]["email_58205344"] || responses[idx]["answers"]["email_58205331"] || responses[idx]["answers"]["email_58205400"] || responses[idx]["answers"]["email_58205374"] || responses[idx]["answers"]["email_58205430"] || responses[idx]["answers"]["email_K7KKS3RFcNMg"] || ""
          if !mail.empty?
            current_user.update(email: mail)
          end
        end
      rescue
      end

      # update user status
      current_consultation.update(user_status: 'form filled', pay_status: 'payment pending')

      # fetch consultation fee
      @amount = current_consultation.amount
      # if amount is 0 then end the consultation and display success page
      if @amount == 0
        redirect_to :success_free
      end
    end
  end

  def issue_payment_paytm
    logger.info "ISSUE PAYMENT PAYTM"
    logger.info params

    payment_params = build_paytm_params
    # remove NB, DC, CC
    payment_params[:PAYMENT_MODE_ONLY] = "YES";
    payment_params[:AUTH_MODE] = "USRPWD";
    payment_params[:PAYMENT_TYPE_ID] = "PPI"

    checksum_hash = new_pg_checksum(payment_params, PAYTM_MERCHANT_KEY).gsub("\n",'')
    current_user.payments.create(user_payment_params(payment_params, "pending", "PAYTM"))
    # current_payment.update(user_payment_params(payment_params, "pending", "PAYTM"))
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

  def payment_paytm_update
    payment_params = build_paytm_params_update
    # remove NB, DC, CC
    payment_params[:PAYMENT_MODE_ONLY] = "YES";
    payment_params[:AUTH_MODE] = "USRPWD";
    payment_params[:PAYMENT_TYPE_ID] = "PPI"

    current_payment.update(:pg_type => "PAYTM")
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
    logger.info "Payment Controller: in initiate_payment. Issue payment for #{current_consultation.id}"
    # logger.info "Payment Controller: #{session[:txnid]}"
    # if session[:txnid].blank?
    logger.info "Payment Controller: Build new transaction"
    payment_params = { :txnid => build_transaction_id, :amount => current_consultation.amount.round(2) }
    current_user.payments.create(user_payment_params(payment_params, "pending", "RAZORPAY"))
    # session[:txnid] = current_user.payments.last.txnid
    logger.info session[:txnid]
    # end
    render :json => { :value => "success" }
  end

  def success_free
    # success page for free consultations
    logger.info "Payment Controller: free success page rendered"
    render 'success_free'

    # initiate job - send user mail
    CustomerPaidMailer.send_customer_txn_mail(current_consultation).deliver_later if current_user.email.present? and Rails.env.production?
    # initiate job - send sms
    SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
    # initiate job - send admin mail for free consultation
    AdminTransactionMailer.send_free_consultation_notifier_mail(current_consultation).deliver_later if Rails.env.production?

    # update details
    # assign_consultation_to_doctor current_consultation
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
    # redirect to page for paid consultations
    logger.info "Payment Controller: in success"
    logger.info params
    if params[:pg_type]=="RAZORPAY"
      current_payment.update({:pg_type => "RAZORPAY"})
    end

    if current_payment.pg_type=='PAYTM'
      # issuing paytm payment
      posted_hash = params["hash"]
      paytm_params = Hash.new
      params.keys.each do |k|
        unless ["CHECKSUMHASH", "action", "controller"].include? k
          paytm_params[k] = params[k]
        end
      end

      checksum_hash = params["CHECKSUMHASH"]
      if params["STATUS"] == "TXN_FAILURE"
        session[:error_msg] = "user cancelled the payment"
        logger.error "looks like #{current_user.name} has cancelled the payment"
        current_payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: params['BANKTXNID']})
        AdminTransactionMailer.error_email("#{current_user.name} has cancelled the payment").deliver
        redirect_to :failure
      elsif not new_pg_verify_checksum(paytm_params, checksum_hash, PAYTM_MERCHANT_KEY)
        session[:error_msg] = "Invalid Checksum!"
        logger.error "invalid checksum for #{current_user.name}"
        current_payment.update({status: 'Invalid Checksum!'})
        AdminTransactionMailer.error_email("invalid checksum for " + current_user.name).deliver
        redirect_to :failure
      elsif params["STATUS"] == "TXN_SUCCESS"
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
        # assign_consultation_to_doctor current_consultation
        current_user.update({pay_status: "paid"})
        current_consultation.update({ pay_status: "paid", user_status: 'paid' })

        # initiate job - send user mail
        CustomerPaidMailer.send_customer_txn_mail(current_consultation).deliver_later if current_user.email.present? and Rails.env.production?
        # initiate job - send sms
        SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
        current_payment.update({mode: params['PAYMENTMODE'], status: 'paid', bank_ref_num: params['BANKTXNID']})
        # initiate job - send admin mail a paid consultation
        # AdminTransactionMailer.send_user_payment_mail(current_user, current_payment, current_consultation.doctor.short_name).deliver_later
        AdminTransactionMailer.send_user_payment_mail(current_user, current_payment, '').deliver_later
        
        coupon = Coupon.find_by_id current_consultation.coupon_id
        if coupon
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end
        render 'success'
        patient_referral = PatientReferral.where(:referee => current_user, :paid => false).last
        patient_referral.update({:consultation => current_consultation, :paid => true}) if patient_referral
        unregister_consultation
        unregister
      else
        url = URI.parse("https://secure.paytm.in/oltp/HANDLER_INTERNAL/getTxnStatus")
        con = Net::HTTP.new(url.host, url.port )
        con.use_ssl = true
        request_data = {"MID": params["MID"], "ORDERID": params["ORDERID"]}
        new_checksum_hash = new_pg_checksum(request_data, PAYTM_MERCHANT_KEY).gsub("\n",'')
        request_data["CHECKSUMHASH"] = new_checksum_hash
        resp, data = con.get url.path + "?JsonData=" + request_data.to_json
        logger.info resp.body

        current_user.update({pay_status: "processing"})
        current_consultation.update({ pay_status: "processing", user_status: 'processing' })

        FetchPaymentStatusWorker.perform_in(20.minutes, current_payment.id) if Rails.env.production?

        render 'pending'
      end
    elsif current_payment.pg_type=='RAZORPAY'

      # issuing razorpay payment
      Rails.logger.info params
      amount = current_consultation.amount*100
      response = Razorpay::Payment.fetch(params[:payment_id])
      if (response.status=='authorized')
        response = response.capture({amount:amount})

        # assign_consultation_to_doctor current_consultation
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

        CustomerPaidMailer.send_customer_txn_mail(current_consultation).deliver_later if current_user.email.present? and Rails.env.production?
        SmsServiceController.send_sms(current_user.id, 'paid', current_consultation.id) if Rails.env.production?
        current_payment.update({pg_type: 'RAZORPAY', mode: mode, status: 'paid', bank_ref_num: response.id})
        AdminTransactionMailer.send_user_payment_mail(current_user, current_payment, '').deliver_later if Rails.env.production?
        coupon = Coupon.find_by_id current_consultation.coupon_id
        if coupon
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end

        render 'success'
        patient_referral = PatientReferral.where(:referee => current_user, :paid => false).last
        patient_referral.update({:consultation => current_consultation, :paid => true}) if patient_referral
        unregister_consultation
        unregister
      elsif
        session[:error_msg] = "Authorization Error!"
        logger.info response
        current_payment.update({status: 'Authorization Error!'})
        AdminTransactionMailer.error_email("razorpay payment not authorized for " + current_user.name).deliver
        redirect_to :failure
      end
    end
  end

  def failure
    logger.info "Payment Controller: error msg ${session[:error_msg]} set"
    session[:error_msg] ||= params['error_Message'] + "|" + params['unmappedstatus']
    current_user.update({pay_status: "payment failed: #{session[:error_msg]}"})
    current_consultation.update({ pay_status: "payment failed: #{session[:error_msg]}", user_status: "payment failed" })
    render 'failure'
  end

  def flag
    @age = session[:tmp_age] if session[:tmp_age]

    render 'flag'
    session[:error_status] = '';
    if session[:tmp_age]
      session[:error_status] = 'age';
    else
      if ['Acne', 'Hairfall or Hair Thinning', 'Dandruff', 'Stretch Marks', 'General Skin Care'].include? current_consultation.category
        session[:error_status] = 'personal or family history of skin cancer';
      elsif ['Pigmentation and Dark Circles', 'Eczema, Psoriasis and Rash', 'Skin Growth (Moles, Warts)'].include? current_consultation.category
        session[:error_status] = session[:tmp_red_flag]
      end
    end
    current_user.update({pay_status: "red flag: #{session[:error_status]}"})
    current_consultation.update({ pay_status: "red flag: #{session[:error_status]}", user_status: "red flag" })
  end

  def instant_payment
    # decrypt the id
    id = decrypt(params[:p], 1)
    logger.info "Payment Controller: in instant payment with id #{id}"
    if id.nil?
      # id does not exist
      redirect_to "/?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
    else
       # id exists, get consultation with that id
      @consultation = Consultation.find_by_id id
      if @consultation
        register @consultation.patient
        register_consultation @consultation
        return redirect_to "/consult/payment?city=null&"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
      else
        redirect_to "/?"+params.permit(:utm_source, :utm_medium, :utm_campaign).to_query
      end
    end
  end

  def chatbot_handler
    current_consultation.questionnaire_response.update({:status => 'form filled', :form_finished_at => DateTime.now()})
    current_consultation.update(user_status: 'form filled', pay_status: 'payment pending')

    current_user.sex = current_consultation.questionnaire_response.responses["2"]["answer"] if current_consultation.questionnaire_response.responses["2"]
    current_user.age = current_consultation.questionnaire_response.responses["3"]["answer"] if current_consultation.questionnaire_response.responses["3"]
    current_user.email = current_consultation.questionnaire_response.responses["68"]["answer"] if current_consultation.questionnaire_response.responses["68"]
    current_user.city = current_consultation.questionnaire_response.responses["56"]["answer"] if current_consultation.questionnaire_response.responses["56"]
    current_user.save!

    questionnaire_images = []
    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["14"], :image_type => 'face front' }) if current_consultation.questionnaire_response.responses["14"]

    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["16"], :image_type => 'face left' }) if current_consultation.questionnaire_response.responses["16"]

    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["18"], :image_type => 'face right' }) if current_consultation.questionnaire_response.responses["18"]

    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["19"], :image_type => 'chest' }) if current_consultation.questionnaire_response.responses["19"]

    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["20"], :image_type => 'back' }) if current_consultation.questionnaire_response.responses["20"]

    questionnaire_images.push({ :image => current_consultation.questionnaire_response.responses["21"], :image_type => 'shoulders' }) if current_consultation.questionnaire_response.responses["21"]

    questionnaire_image_records = questionnaire_images.map {|image| QuestionnaireResponseImage.new(image) }
    current_consultation.questionnaire_response.questionnaire_response_images << questionnaire_image_records

    AdminTransactionMailer.send_user_form_filled_notifier_mail(current_consultation).deliver if Rails.env.production?


    if current_user.city.nil?
      session[:tmp_age] = nil
      unless current_user.age.nil?
        session[:tmp_age] = current_user.age if !current_user.age.to_i.between?(3, 65)
      end
      session[:tmp_red_flag] = 'Yes'
      session[:tmp_red_flag_type] = 'chatbot'
      redirect_to :flag
      return
    end

    # fetch consultation fee
    @amount = current_consultation.amount
    # if amount is 0 then end the consultation and display success page
    if @amount.zero?
      redirect_to :success_free
    end
    # show him payments screen
  end

  private

    def current_payment
      current_user.payments.find_by txnid: session[:txnid]
    end

    def update_payment
      logger.info "UPDATE PAYMENT"
      logger.info current_user.payments
      current_payment.update(capture_params) if !current_payment.nil?
      unregister_consultation
      unregister
    end

end

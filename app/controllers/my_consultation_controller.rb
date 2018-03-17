class MyConsultationController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'net/https'
  require 'encrypt'
  require 'razorpay'
  PAYTM_MERCHANT_KEY = Rails.application.secrets.PAYTM_MERCHANT_KEY
  PAYTM_INITIAL_TRASACTION_URL = Rails.application.secrets.PAYTM_INITIAL_TRASACTION_URL
  include MyConsultationHelper
  include PaymentHelper
  include PaytmHelper
  
  skip_before_action :verify_authenticity_token, only: [:create, :success, :failure, :initiate_payment, :continue_consultation]
  before_action :check_my_consultation, except: [:create, :failure, :continue_consultation]

  def create
    if session[:promo_code]
      coupon = Coupon.find_by coupon_code: session[:promo_code]
      if coupon.discount_amount == 350
        redirect_to '/consult/patients?name='+params[:name]+'&mobile='+params[:mobile]+'&referrer='+(params[:referrer]||'')+'&utm_campaign='+(params[:utm_campaign]||'')
        return
      end
    end
    unless my_consultation
      # create new my_consultation  
      @my_consultation = MyConsultation.find_or_initialize_by(my_consultation_params)
      if @my_consultation.save
        # register my_consultation in session
        register_my_consultation @my_consultation
        # redirect to choose condition
        if session[:promo_code]
          coupon = Coupon.find_by coupon_code: session[:promo_code]
          @my_consultation.update({:amount => (350 - coupon.discount_amount), :coupon_id => coupon.id})
        end
        redirect_to '/my_consultation/payment' if @my_consultation.blank?
      else
        return redirect_to "/"
      end
    else
      if (['paid', 'form started', 'red flag'].include? my_consultation.user_status)
        redirect_to '/my_consultation/payment_success?mobile='+my_consultation.mobile
        return
      end
    end
  end

  def save_condition
    my_consultation.update({:category => params[:condition]})
    redirect_to '/my_consultation/payment'
  end
  
  def payment
  end
  
  def initiate_payment
    payment_params = { :txnid => build_transaction_id_external(my_consultation), :amount => my_consultation.amount.round(2), :pg_type => "RAZORPAY" }
    my_consultation.update(payment_params)
    render :json => { :value => "success" }
  end
  
  def payment_paytm_update
    payment_params = build_paytm_params_update
    # remove NB, DC, CC
    payment_params[:PAYMENT_MODE_ONLY] = "YES";
    payment_params[:AUTH_MODE] = "USRPWD";
    payment_params[:PAYMENT_TYPE_ID] = "PPI"

    my_consultation.update(:pg_type => "PAYTM")
    checksum_hash = new_pg_checksum(payment_params, PAYTM_MERCHANT_KEY).gsub("\n",'')
    @content_paytm = "<html><head><meta http-equiv=\"Content-Type\" content=\"text/html;charset=ISO-8859-I\"><title>Paytm</title></head><body><center><h2>Redirecting to Paytm </h2><br /><h1>Please do not refresh this page...</h1></center><form method=\"post\" action=\"#{PAYTM_INITIAL_TRASACTION_URL}\" name=\"f1\">"
      keys = payment_params.keys
      keys.each do |k|
        @content_paytm +=  "<input type=\"hidden\" name=\"#{k}\" value=\"#{payment_params[k]}\">"
      end
    @content_paytm = @content_paytm + "<input type=\"hidden\" name=\"CHECKSUMHASH\" value=\"#{checksum_hash}\"></form><script type=\"text/javascript\">document.f1.submit();</script></body></html>"
    logger.info "patient: #{my_consultation.name} redirected to paytm"
    logger.info @content_paytm
    return render html: @content_paytm.html_safe
  end
  
  def payment_success
    if params[:pg_type]=="RAZORPAY"
      my_consultation.update({:pg_type => "RAZORPAY"})
    end
    
    if my_consultation.pg_type=='PAYTM'
      # issuing paytm payment
      paytm_params = Hash.new
      params.keys.each do |k|
        unless ["CHECKSUMHASH", "action", "controller"].include? k
          paytm_params[k] = params[k]
        end
      end

      checksum_hash = params["CHECKSUMHASH"]
      if params["STATUS"] == "TXN_FAILURE"
        session[:error_msg] = "user cancelled the payment"
        logger.error "looks like #{my_consultation.name} has cancelled the payment"
        my_consultation.update({mode: '', pay_status: 'cancelled_by_customer', bank_ref_num: params['BANKTXNID']})
        redirect_to '/my_consultation/failure'
      elsif not new_pg_verify_checksum(paytm_params, checksum_hash, PAYTM_MERCHANT_KEY)
        session[:error_msg] = "Invalid Checksum!"
        logger.error "invalid checksum for #{my_consultation.name}"
        my_consultation.update({pay_status: 'Invalid Checksum!'})
        ErrorEmailer.error_email("invalid checksum for " + my_consultation.name).deliver
        redirect_to '/my_consultation/failure'
      elsif params["STATUS"] == "TXN_SUCCESS"
        url = URI.parse("https://secure.paytm.in/oltp/HANDLER_INTERNAL/getTxnStatus")
        con = Net::HTTP.new(url.host, url.port )
        con.use_ssl = true
        request_data = {"MID": params["MID"], "ORDERID": params["ORDERID"]}
        new_checksum_hash = new_pg_checksum(request_data, PAYTM_MERCHANT_KEY).gsub("\n",'')
        request_data["CHECKSUMHASH"] = new_checksum_hash
        resp, data = con.get url.path + "?JsonData=" + request_data.to_json

        my_consultation.update({mode: params['PAYMENTMODE'], status: 'paid', bank_ref_num: params['BANKTXNID'], pay_status: "paid", user_status: 'paid' })
        
        coupon = Coupon.find_by_id my_consultation.coupon_id
        if coupon
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end
        CustomerPaymentNotifierMailer.send_user_reverse_payment_mail(my_consultation).deliver_later if Rails.env.production?
        render 'payment_success'
      else
        url = URI.parse("https://secure.paytm.in/oltp/HANDLER_INTERNAL/getTxnStatus")
        con = Net::HTTP.new(url.host, url.port )
        con.use_ssl = true
        request_data = {"MID": params["MID"], "ORDERID": params["ORDERID"]}
        new_checksum_hash = new_pg_checksum(request_data, PAYTM_MERCHANT_KEY).gsub("\n",'')
        request_data["CHECKSUMHASH"] = new_checksum_hash
        resp, data = con.get url.path + "?JsonData=" + request_data.to_json
        logger.info resp.body

        my_consultation.update({ pay_status: "processing", user_status: 'processing' })

        redirect_to '/my_consultation/failure'
      end
    elsif my_consultation.pg_type=='RAZORPAY'
      amount = my_consultation.amount*100
      response = Razorpay::Payment.fetch(params[:payment_id])
      if (response.status=='authorized')
        CustomerPaymentNotifierMailer.send_user_reverse_payment_mail(my_consultation).deliver_later if Rails.env.production?
        render 'payment_success'
  
        response = response.capture({amount:amount})
        mode = case response.method
        when "netbanking"
          "netbanking - " + response.bank
        when  "wallet"
          "wallet - " + response.wallet
        else
          response.method
        end
  
        my_consultation.update({ pay_status: "paid", user_status: 'paid', pg_type: 'RAZORPAY',  mode: mode, bank_ref_num: response.id})
        unless my_consultation.coupon.nil?
          coupon = Coupon.find_by_id my_consultation.coupon_id
          coupon.increment!(:count, 1)
          coupon.update(status: 'coupon used')
        end
      elsif
        session[:error_msg] = "Authorization Error!"
        my_consultation.update({pay_status: 'Authorization Error!'})
        redirect_to '/my_consultation/failure'
      end
    end
  end

  def continue_consultation
    if my_consultation && (['paid', 'form started', 'red flag'].include? my_consultation.user_status)
      return
    else
      if params[:mobile]
        @my_consultation = MyConsultation.find_by :mobile => params[:mobile], :user_status => ['paid', 'form started', 'red flag']
        if @my_consultation
          register_my_consultation @my_consultation
          return
        end
      end
    end
    redirect_to '/'
  end

  def failure
    my_consultation.update({ pay_status: "payment failed: #{session[:error_msg]}", user_status: "payment failed" })
  end

  def consultation_form
    my_consultation.update({:user_status => 'form started'})
    typeform = {
      "Acne" => "https://remedica.typeform.com/to/Eb3Oby",
      "Hairfall or Hair Thinning" => "https://remedica.typeform.com/to/WqEAeB",
      "Pigmentation and Dark Circles" => "https://remedica.typeform.com/to/RgTtE0",
      "Dandruff" => "https://remedica.typeform.com/to/WqEAeB",
      "Eczema, Psoriasis and Rash" => "https://remedica.typeform.com/to/VuHuwt",
      "Stretch Marks" => "https://remedica.typeform.com/to/lSTMhj",
      "Skin Growth (Moles, Warts)" => "https://remedica.typeform.com/to/qs6Oc7",
      "General Skin Care" => "https://remedica.typeform.com/to/iR4wrM"
    }
    @condition_form = typeform[my_consultation.category] << "?mobile=#{my_consultation.mobile}&name=#{my_consultation.name}"
    session[:typeform_uid] = typeform[my_consultation.category].scan(/\/([\w]*)\?/)[0][0]
  end
  
  def success
    @name = my_consultation.name.titleize
    unless params[:age].blank?
      my_consultation.age = params[:age] unless params[:age].blank?
      my_consultation.city = params[:city] unless params[:city].blank?
      my_consultation.sex = params[:sex] unless params[:sex].blank?
      my_consultation.save!
    end
    if params[:city].blank?
      session[:tmp_age] = nil
      unless params[:age].empty?
        session[:tmp_age] = params[:age] if !params[:age].to_i.between?(3, 65)
      end
      session[:tmp_red_flag] = params[:redflag].humanize.reverse.sub(','.reverse, ' and'.reverse).reverse
      redirect_to '/my_consultation/flag'
    else
      # get email of the current user from typeform responses and store it
      begin
        typeform_uid = session[:typeform_uid]
        if typeform_uid
          response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
          response = JSON.parse(response.body)
          responses = response["responses"]
          mobile_nos = responses.collect { |x| x["hidden"]["mobile"] }
          idx = mobile_nos.index(my_consultation.mobile)
          mail = responses[idx]["answers"]["email_58205238"] || responses[idx]["answers"]["email_58205344"] || responses[idx]["answers"]["email_58205331"] || responses[idx]["answers"]["email_58205400"] || responses[idx]["answers"]["email_58205374"] || responses[idx]["answers"]["email_58205430"] || ""
          if !mail.empty?
            my_consultation.email = mail
          end
        end
      rescue
      end

      # update user status
      my_consultation.user_status = 'form filled'
      my_consultation.save!
      unregister_my_consultation
    end
  end
  
  def flag
    @age = session[:tmp_age] if session[:tmp_age]

    render 'flag'
    session[:error_status] = '';
    if session[:tmp_age]
      session[:error_status] = 'age';
    else
      if ['Acne', 'Hairfall or Hair Thinning', 'Dandruff', 'Stretch Marks', 'General Skin Care'].include? my_consultation.category
        session[:error_status] = 'personal or family history of skin cancer';
      elsif ['Pigmentation and Dark Circles', 'Eczema, Psoriasis and Rash', 'Skin Growth (Moles, Warts)'].include? my_consultation.category
        session[:error_status] = session[:tmp_red_flag]
      end
    end
    my_consultation.update({ pay_status: "red flag: #{session[:error_status]}", user_status: "red flag" })
  end

  private
    # filter parameters
    def my_consultation_params
      {
        mobile: params[:mobile],
        name: (params[:name] || "").downcase.titleize.strip,
        local_referrer: (params[:referrer]||'').downcase,
        utm_campaign: (params[:utm_campaign]||'').downcase,
        category: (session[:condition]||'')
      }
    end
    
end

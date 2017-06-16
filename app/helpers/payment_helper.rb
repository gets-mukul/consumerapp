module PaymentHelper
  require 'digest'
  KEY = Rails.application.secrets.PAYU_IN_KEY
  SALT = Rails.application.secrets.PAYU_IN_SALT

  def build_payment_params
    txnid = build_transaction_id
    desc = "Remedico treatment for #{current_user.name}"
    amount = 350.round(2)

    sha512 = OpenSSL::Digest::SHA512.new
    string = [KEY,txnid,amount.to_s,desc,current_user.name,current_user.email,"|||||||||",SALT].join("|")
    hash = sha512.hexdigest(string)
    {
      :key	=> KEY,
      :HASH => hash,
      :txnid	=> txnid,
      :amount	=> amount,
      :productinfo	=> desc,
      :firstname	=> current_user.name,
      :email => current_user.email,
      :phone	=> current_user.mobile,
      :surl	=> Rails.application.secrets.DOMAIN + '/payment/success',
      :furl	=> Rails.application.secrets.DOMAIN + '/payment/failure',
      :service_provider => 'payu_paisa'
    }
  end

  def build_paytm_params
    txnid = build_transaction_id
    amount = 350.round(2)
    {
      :MERCHANT_KEY	=> "1HmXDh!#8ODH7FO6",
      :MID => "Remedy24705119328083",
      :txnid	=> txnid,
      :CHANNEL_ID => "WEB",
      :TXN_AMOUNT	=> amount,
      :INDUSTRY_TYPE_ID => "Retail",
      :WEBSITE => "WEB_STAGING",
      :CUST_ID => current_user.id,
      :ORDER_ID => "",
      :EMAIL => current_user.email,
      :MOBILE_NO	=> current_user.mobile,
      :CALLBACK_URL => "localhost:3000"
    }
  end

  def checksum params, current_payment
    add_charge = params["additionalCharges"]
    status = params["status"]
    payment = current_payment if params["txnid"] == session[:txnid]

    sha512 = OpenSSL::Digest::SHA512.new

    if !add_charge.nil?
      string = [add_charge, SALT, status, "|||||||||", current_user.email, current_user.name, payment.desc,'%.1f' % payment.amount, payment.txnid, KEY].join("|")
    else
      string = [SALT, status, "|||||||||", current_user.email, current_user.name, payment.desc,'%.1f' % payment.amount, payment.txnid, KEY].join("|")
    end
    sha512.hexdigest(string)
  end

  private
    def build_transaction_id
      @patient = current_user
      sha256 = OpenSSL::Digest::SHA256.new
      key = @patient.name + @patient.email + @patient.mobile
      txnid = "RE" + sha256.hexdigest(key).to_s[1..16] + Time.now.to_s.gsub(/-|\s|\:|\+/,'')
      session[:txnid] = txnid
    end

    def check_current_user
      if current_user.nil?
        redirect_to '/consult/new_patient'
      end
    end

    def user_payment_params payment_params, mode
      {
        :txnid => payment_params[:txnid],
        :status => "Initiated",
        :amount	=> payment_params[:amount],
        :desc	=> payment_params[:productinfo],
        :mode => mode
      }
    end

    def capture_params
      mihpayid = params["mihpayid"]                                 #	Unique reference no. created at PayUbiz’s end for each transaction.
      mode	= params["mode"].nil? ? "failed" : params[:mode]        # Payment category by which the transaction was completed/ attempted.
      pg_type = params["PG_TYPE"]	                                  # Gives the information of payment gateway used for transaction.
      bank_ref_num = params["bank_ref_num"]	                        # For a successful transaction, this will give you the bank reference number generated at bank’s end.
      status = @error_msg.blank? ? "paid" : @error_msg
      { mihpayid: mihpayid, mode: mode, pg_type: pg_type, bank_ref_num: bank_ref_num, status: status }
    end

    def red_flags
      typeform_uid = session[:typeform_uid]
      if typeform_uid.blank?
        return true
      end
      response = HTTParty.get("https://api.typeform.com/v1/form/" + typeform_uid + "?key=#{Rails.application.secrets.TYPEFORM_API_KEY}&until=#{Time.now.to_i}&limit=10&order_by[]=date_submit,desc")
      if response.code == 200
        json = JSON.parse(response.body)
        if json["responses"].count > 0
          json["responses"].each do |response|
            if response["hidden"]["email"] == current_user.email
              logger.info { "Record for #{current_user.email} found" }
              if response["answers"].count > 8
                logger.info { "#{current_user.email} has more than 8 answers. No Red flags." }
                return false
              else
                logger.info { "#{current_user.email} has less than 8 answers. Red flags presumed." }
                return true
              end
            end
          end
          logger.info { "#{current_user.email} entry not found. Red flags presumed." }
          return true
        else
          logger.info { "Typeform responses = 0. Red flags presumed." }
          return true
        end
      else
        logger.info { "Typeform did not return 200 OK." }
        return true
      end
    end
end

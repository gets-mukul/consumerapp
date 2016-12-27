module PaymentHelper
  require 'digest'
  KEY = Rails.application.secrets.PAYU_IN_KEY
  SALT = Rails.application.secrets.PAYU_IN_SALT

  def build_payment_params mode
    txnid = build_transaction_id
    desc = "Remedica treatment for #{current_user.name}"
    amount = 300.round(2)

    sha512 = OpenSSL::Digest::SHA512.new
    string = [KEY, txnid, amount.to_s, desc, current_user.name, current_user.email,"|||||||||", SALT].join("|")
    hash = sha512.hexdigest(string)
    {
      :key	=> KEY,
      :txnid	=> txnid,
      :amount	=> amount,
      :mode => mode,
      :productinfo	=> desc,
      :firstname	=> current_user.name,
      :email => current_user.email,
      :phone	=> current_user.mobile,
      :surl	=> 'http://localhost:3000/payment/success',
      :furl	=> 'http://localhost:3000/payment/failure',
      :HASH => hash
    }
  end

  def checksum params
    add_charge = params["additionalCharges"]
    status = params["status"]
    payment = current_user.payments.find_by_txnid(session[:txnid]) if params["txnid"] == session[:txnid]

    sha512 = OpenSSL::Digest::SHA512.new

    if !add_charge.nil?
      string = [add_charge, SALT, status, "|||||||||", current_user.email, current_user.name, payment.desc, '%.2f' % payment.amount, payment.txnid, KEY].join("|")
    else
      string = [SALT, status, "|||||||||", current_user.email, current_user.name, payment.desc, '%.2f' % payment.amount, payment.txnid, KEY].join("|")
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
end

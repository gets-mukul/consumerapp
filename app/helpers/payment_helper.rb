module PaymentHelper
  require 'digest'
  def build_payment_params mode
    @txnid = build_transaction_id
    @desc = "Remedica treatment for #{current_user.name}"
    @amount = 300.round(2)

    sha512 = OpenSSL::Digest::SHA512.new
    string = [ENV["TEST_KEY"], @txnid, @amount.to_s, @desc, current_user.name, current_user.email,"|||||||||", ENV["TEST_SALT"]].join("|")
    hash = sha512.hexdigest(string)
    {
      :key	=> ENV["TEST_KEY"],
      :txnid	=> @txnid,
      :amount	=> @amount,
      :mode => mode,
      :productinfo	=> @desc,
      :firstname	=> current_user.name,
      :email => current_user.email,
      :phone	=> current_user.mobile,
      :surl	=> 'http://localhost:3000/payment/success',
      :furl	=> 'http://localhost:3000/payment/failure',
      :HASH => hash
    }
  end

  def checksum status, add_charge
    sha512 = OpenSSL::Digest::SHA512.new
    if !add_charge.nil?
      string = [add_charge, ENV["TEST_SALT"], status, "||||||||||", current_user.email, current_user.name, @desc, @amount.to_s, @txnid, ENV["TEST_KEY"]].join("|")
    else
      string = [ENV["TEST_SALT"], status, "||||||||||", current_user.email, current_user.name, @desc, @amount.to_s, @txnid, ENV["TEST_KEY"]].join("|")
    end
    sha512.hexdigest(string)
  end

  private
    def build_transaction_id
      @patient = current_user
      sha256 = OpenSSL::Digest::SHA256.new
      key = @patient.name + @patient.email + @patient.mobile
      txnid = "RE" + sha256.hexdigest(key).to_s + Time.now.to_s.gsub(/-|\s|\:|\+/,'')
    end
end

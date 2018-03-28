class FetchPaymentStatusWorker
  require 'uri'
  require 'net/http'
  require 'net/https'

	include Sidekiq::Worker
  include PaytmHelper
	sidekiq_options :queue => :low, :retry => 5

	def perform(id)
		puts "SIDEKIQ WORKER RUNNING"
		puts "FETCHING PAYMENT STATUS"
		payment = Payment.find_by_id id

    url = URI.parse("https://secure.paytm.in/oltp/HANDLER_INTERNAL/getTxnStatus")
    con = Net::HTTP.new(url.host, url.port )
    con.use_ssl = true
    
    request_data = {"MID": Rails.application.secrets.MID, "ORDERID": payment.txnid}
    new_checksum_hash = new_pg_checksum(request_data, Rails.application.secrets.PAYTM_MERCHANT_KEY).gsub("\n",'')
    request_data["CHECKSUMHASH"] = new_checksum_hash
    resp, data = con.get url.path + "?JsonData=" + request_data.to_json
    response = JSON.parse(resp.body)

    if response["STATUS"] == "TXN_SUCCESS"
      payment.patient.update({pay_status: "paid"})
      payment.consultation.update({ pay_status: "paid", user_status: 'paid' })

      # initiate job - send user mail
      CustomerPaidMailer.send_customer_txn_mail(payment.consultation).deliver_later if payment.patient.email.present?
      # initiate job - send sms
      SmsServiceController.send_sms(payment.patient.id, 'paid', payment.consultation.id)
      current_payment.update({mode: response['PAYMENTMODE'], status: 'paid', bank_ref_num: response['BANKTXNID']})
      # initiate job - send admin mail a paid consultation
      # AdminTransactionMailer.send_user_payment_mail(current_user, current_payment, current_consultation.doctor.short_name).deliver_later
      AdminTransactionMailer.send_user_payment_mail(payment.patient, payment, '').deliver_later
    else
      error_msg = "user cancelled the payment"
      payment.patient.update({pay_status: "payment failed: user cancelled the payment"})
      payment.consultation.update({ pay_status: "payment failed: user cancelled the payment", user_status: 'payment failed' })
      payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: response['BANKTXNID']})
      AdminTransactionMailer.send_pending_transaction_mail(payment).deliver_later
    end
	end
end

class FetchPaymentStatusWorker
  require 'uri'
  require 'net/http'
  require 'net/https'

	include Sidekiq::Worker
  include PaytmHelper
	sidekiq_options :retry => 5

	def perform(id, time)
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

    if response["STATUS"] == "TXN_FAILURE"
      error_msg = "#{payment.patient.name} has cancelled the payment"
      payment.patient.update({pay_status: "payment cancelled by patient"})
      payment.consultation.update({ pay_status: "payment cancelled by patient", user_status: 'payment failed' })
      current_payment.update({mode: '', status: 'cancelled_by_customer', bank_ref_num: response['BANKTXNID']})
      ErrorEmailer.error_email(error_msg).deliver
    elsif response["STATUS"] == "TXN_SUCCESS"
      payment.patient.update({pay_status: "paid"})
      payment.consultation.update({ pay_status: "paid", user_status: 'paid' })

      # initiate job - send user mail
      UserPaymentNotifierMailer.send_user_payment_mail(payment.patient, payment).deliver_later if payment.patient.email.present?
      # initiate job - send sms
      SmsServiceController.send_sms(payment.patient.id, 'paid', payment.consultation.id)
      current_payment.update({mode: response['PAYMENTMODE'], status: 'paid', bank_ref_num: response['BANKTXNID']})
      # initiate job - send admin mail a paid consultation
      # CustomerPaymentNotifierMailer.send_user_payment_mail(current_user, current_payment, current_consultation.doctor.short_name).deliver_later
      CustomerPaymentNotifierMailer.send_user_payment_mail(payment.patient, payment, '').deliver_later
    else
      AdminTransactionMailer.send_pending_transaction_mail(payment).deliver_later
    end
	end
end

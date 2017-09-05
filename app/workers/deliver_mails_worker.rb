class DeliverMailsWorker
	include Sidekiq::Worker

	def perform(consultation)
		puts "SIDEKIQ WORKER RUNNING"
		puts "DELIVER MAILS"
		if consultation.user_status == 'form filled' and consultation.patient.email.present?
			UserPaymentNotifierMailer.send_user_form_filled_mail(consultation).deliver_later
		end

	end

end
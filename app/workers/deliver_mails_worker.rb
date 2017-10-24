class DeliverMailsWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 5

	def perform(id)
		puts "SIDEKIQ WORKER RUNNING"
		puts "DELIVER MAILS"
		consultation = Consultation.find_by_id id
		if consultation.user_status == 'form filled' and consultation.patient.email.present?
			UserPaymentNotifierMailer.send_user_form_filled_mail(id).deliver_later
		end
		puts "DELIVERED MAILS"
	end
end

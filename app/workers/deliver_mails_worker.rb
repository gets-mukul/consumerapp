class DeliverMailsWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :default, :retry => 5

	def perform(id)
		puts "SIDEKIQ WORKER RUNNING"
		puts "DELIVER MAILS"
		consultation = Consultation.find_by_id id
		if consultation.user_status.start_with?('form filled', 'payment failed', 'processing') and consultation.patient.email.present?
			CustomerFormFilledMailer.send_customer_txn_locked_plan_testimonials_mail(consultation).deliver_later
		end
		puts "DELIVERED MAILS"
	end
end

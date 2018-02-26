class DeliverSMSWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false

	def perform(id)
		puts "SIDEKIQ WORKER RUNNING"
		puts "DELIVER SMS"

		sent_sms = SmsService.where(patient_id: id).where("created_at >= ?", DateTime.now-0.25)
		unless sent_sms.present?
			consultation = Consultation.where(patient_id: id).where("created_at >= ?", DateTime.now-0.5).order('id desc')
			if consultation.present?
				latest_order = ["paid", "free consultation done", "payment failed", "processing", "form filled", "red flag", "registered"]
				sorted_consultation = consultation.sort_by{|x| latest_order.index x.user_status}[0]
				puts sorted_consultation.id
				if sorted_consultation.user_status.start_with?('form fill', 'payment failed', 'processing')
					SmsServiceController.send_sms(id, "form filled", sorted_consultation.id)
				elsif sorted_consultation.user_status.start_with? 'register'
					SmsServiceController.send_sms(id, "registered", sorted_consultation.id)
				end
			else
				SmsServiceController.send_sms(id, "registered", "")
			end
			puts "DELIVERED SMS"
		end
	end
end

class SendOutDailySelfieCheckupStatsWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :low, :retry => 5

	def perform(*args)
		puts "SIDEKIQ WORKER RUNNING"
		args.each do |doctor_id|
			doctor = Doctor.find(doctor_id)
			stats = {
				:pending => SelfieForm.all.where(:doctor => doctor, :status => 'pending').count,
				:overdue => SelfieForm.all.where(:doctor => doctor, :status => 'pending').where('created_at <= ?', (Time.now - 24.hours)).count
			}
			puts "SENDING EMAILS TO #{doctor.email}"
			unless stats[:pending].zero?
				DoctorNotifierMailer.send_selfie_stats_mail(doctor, stats).deliver_later()
				SmsServiceController.send_doctor_stats_sms(doctor, stats)
			end
		end
		puts "DELIVERED DOCTOR MAILS"
	end
end

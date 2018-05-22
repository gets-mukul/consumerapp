class SendOutDailySelfieCheckupStatsWorker
	include Sidekiq::Worker
	sidekiq_options :retry => 5

	def perform(*args)
		puts "SIDEKIQ WORKER RUNNING"
		args.each do |doctor_id|
			doctor = Doctor.find(doctor_id)
			stats = {
				:pending => SelfieForm.all.where(:doctor => doctor, :status => 'pending').count,
				:overdue => SelfieForm.all.where(:doctor => doctor, :status => 'pending').where('created_at <= ?', (Time.now - 24.hours)).count
			}
			DoctorNotifierMailer.send_selfie_stats_mail(doctor, stats)
		end
		puts "DELIVERED DOCTOR MAILS"
	end
end

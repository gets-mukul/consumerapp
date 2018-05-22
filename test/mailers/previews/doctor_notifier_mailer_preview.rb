# Preview all emails at http://localhost:3000/rails/mailers/doctor_notifier_mailer
class DoctorNotifierMailerPreview < ActionMailer::Preview

  def send_selfie_stats_mail
    doctor_id = 1
    doctor = Doctor.find(doctor_id)
    stats = {
      :pending => SelfieForm.all.where(:doctor => doctor, :status => 'pending').count,
      :overdue => SelfieForm.all.where(:doctor => doctor, :status => 'pending').where('created_at <= ?', (Time.now - 24.hours)).count
    }
    DoctorNotifierMailer.send_selfie_stats_mail(doctor, stats)
  end

end

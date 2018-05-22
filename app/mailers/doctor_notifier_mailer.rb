class DoctorNotifierMailer < ApplicationMailer

  def send_selfie_stats_mail(doctor, stats)
    @doctor = doctor
    @stats = stats
    subject = "Remedico: Selfie Checkup stats"

    mail( :to => @doctor.email, :subject => subject )
  end

end

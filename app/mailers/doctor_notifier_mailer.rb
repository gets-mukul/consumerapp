class DoctorNotifierMailer < ApplicationMailer

  def send_selfie_stats_mail(doctor, stats)
    @doctor = doctor
    @stats = stats

    # mail( :to => "jesse@remedicohealth.com",
    mail( :to => @doctor.email,
    :subject => "Remedico: Selfie Checkup stats" )
  end

end

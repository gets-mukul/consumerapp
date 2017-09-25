class FreeConsultationNotifierMailer < ApplicationMailer

  def send_free_consultation_notifier_mail(consultation)
    @consultation = consultation
    @coupon = Coupon.find_by_id @consultation.coupon_id
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedico: Free consultation notice." )
  end

end

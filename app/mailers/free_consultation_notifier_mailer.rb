class FreeConsultationNotifierMailer < ApplicationMailer

  def send_user_payment_mail(consultation)
    @consultation = consultation
    @coupon = Coupon.find_by_id @consultation.coupon_id
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedico: Free consultation notice." )
  end

end

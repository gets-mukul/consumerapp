class CustomerPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment, doctor)
    @user = user
    @payment = payment
    @doctor = doctor
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedico: User payment notice." )
  end

  def send_user_reverse_payment_mail(my_consultation)
    @my_consultation = my_consultation
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, 'jesse@remedicohealth.com', 'mail@akhilsingh.net'],
    :subject => "Remedico: User payment notice for reverse payment flow." )
  end

end

class CustomerPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment, doctor)
    @user = user
    @payment = payment
    @doctor = doctor
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedico: User payment notice." )
  end

end

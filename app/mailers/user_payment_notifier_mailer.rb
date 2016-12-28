class UserPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment)
    @user = user
    @payment = payment
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedica: User payment notice." )
  end
end

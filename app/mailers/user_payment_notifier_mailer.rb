class UserPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment)
    @user = user
    @payment = payment
    mail( :to => @user.email,
    :subject => "Remedica: Payment notice." )
  end
end

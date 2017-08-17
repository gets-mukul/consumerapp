class UserPaymentNotifierMailer < ApplicationMailer

  def send_user_payment_mail(user, payment)
    @user = user
    @payment = payment
    mail( :to => [@user.email, "jesse.dhara@gmail.com"],
    # mail( :to => @user.email,
    :subject => "Remedico: Payment notice." )
  end
end

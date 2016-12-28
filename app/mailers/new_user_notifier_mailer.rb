class NewUserNotifierMailer < ApplicationMailer

  def send_new_user_mail(user)
    @user = user
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    :subject => "Remedica: New user sign up." )
  end
end

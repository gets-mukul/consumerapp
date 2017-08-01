class NewUserNotifierMailer < ApplicationMailer

  def send_new_user_mail(user, referrer)
    @user = user
    @referrer = referrer.downcase.to_s;
    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedica: New user sign up." )
  end
end

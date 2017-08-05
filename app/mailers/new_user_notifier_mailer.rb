class NewUserNotifierMailer < ApplicationMailer

  def send_new_user_mail(user, referrer)
    @user = user
    @referrer = referrer.downcase.to_s;
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedica: New user sign up." )
  end

  def send_new_user_mail_with_insta(user, referrer, insta, promo_code)
    @user = user
    @referrer = referrer.downcase.to_s;
    @insta = insta
    @promo_code = promo_code
    # mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedica: New user sign up." )
  end

end

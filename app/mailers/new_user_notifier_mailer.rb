class NewUserNotifierMailer < ApplicationMailer

  def send_new_user_mail(user, referrer, coupon_code="")
    @user = user
    @referrer = referrer.downcase.to_s;
    @coupon_code = coupon_code
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedica: New user sign up." )
  end

  def send_new_user_mail_with_insta(user, referrer, insta, promo_code)
    @user = user
    @referrer = referrer.downcase.to_s;
    @insta = insta.to_s
    @promo_code = promo_code.to_s
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedica: New user sign up." )
  end

end

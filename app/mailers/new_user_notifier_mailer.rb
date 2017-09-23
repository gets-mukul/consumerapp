class NewUserNotifierMailer < ApplicationMailer

  def send_new_user_mail(user, coupon_code="")
    @user = user
    @coupon_code = coupon_code
    if !@coupon_code.empty?
      mail( :to => Rails.application.secrets.ADMIN_EMAIL,
      # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
      # mail( :to => "jesse.dhara@gmail.com",
      :subject => "Remedica: New coupon sign up." )
    else
      mail( :to => Rails.application.secrets.ADMIN_EMAIL,
      # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
      # mail( :to => "jesse.dhara@gmail.com",
      :subject => "Remedica: New user sign up." )
    end

  end

  def send_new_user_mail_with_insta(user, insta, promo_code)
    @user = user
    @insta = insta.to_s
    @promo_code = promo_code.to_s
    mail( :to => Rails.application.secrets.ADMIN_EMAIL,
    # mail( :to => [Rails.application.secrets.ADMIN_EMAIL, "jesse.dhara@gmail.com"],
    # mail( :to => "jesse.dhara@gmail.com",
    :subject => "Remedico: New user sign up." )
  end

end

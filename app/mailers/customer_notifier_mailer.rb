class CustomerNotifierMailer < ApplicationMailer

  def send_selfie_diagnosis_mail(user, selfie_link)
    @user = user
    @selfie_link = selfie_link
    mail( :to =>  @user.email,
    :subject => "Remedico: Your Selfie Diagnosis!" )
  end

  def send_selfie_bad_photo_mail(user)
    @user = user
    mail( :to =>  @user.email,
    :subject => "Remedico: Selfie Diagnosis!" )
  end

  def send_selfie_no_condition_mail(user)
    @user = user
    mail( :to =>  @user.email,
    :subject => "Remedico: Your Selfie Diagnosis!" )
  end

end

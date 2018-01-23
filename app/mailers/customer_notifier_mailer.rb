class CustomerNotifierMailer < ApplicationMailer

  def send_selfie_diagnosis_mail(user, selfie_link)
    @user = user
    @selfie_link = selfie_link
    mail( :to =>  @user.email,
    :subject => "Remedico: Your Selfie Diagnosis!" )
  end

end

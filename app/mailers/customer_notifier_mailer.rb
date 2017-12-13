class CustomerNotifierMailer < ApplicationMailer

  def send_selfie_diagnosis_mail(user, selfie)
    @user = user
    @selfie = selfie
    mail( :to =>  @user.email,
    :subject => "Remedico: Selfie Diagnosis is ready!" )
  end

end

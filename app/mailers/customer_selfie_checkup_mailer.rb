class CustomerSelfieCheckupMailer < ApplicationMailer

  def send_customer_diagnosis_mail(user, diagnosis_link)
    @user = user
    @diagnosis_link = diagnosis_link + '&utm_source=selfiecheckup&utm_medium=email&utm_campaign=sc_diagnosis_d0_v1'
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_diagnosis_d0_v1"] }.to_json

    mail( :to => @user.email, :subject => "The results are in! - Selfiecheckup" )
  end

  def send_customer_no_condition_mail(user)
    @user = user
    @general_skin_care_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL100&utm_source=selfiecheckup&utm_medium=email&utm_campaign=sc_no_condition_d0_v1&url=patients&condition=General%20Skin%20Care&name="+@user.name+"&mobile="+@user.mobile
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_no_condition_d0_v1"] }.to_json

    mail( :to => @user.email, :subject => "The results are in. Your skin is amazing!" )
  end

  def send_customer_bad_photo_mail(user)
    @user = user
    @selfie_checkup_link = "https://remedicohealth.com/consult/selfie_form?utm_source=selfiecheckup&utm_medium=email&utm_campaign=sc_bad_photo_d0_v1"
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_bad_photo_d0_v1"] }.to_json
    
    mail( :to => @user.email, :subject => "Oops! We want to see. how you look" )
  end

end

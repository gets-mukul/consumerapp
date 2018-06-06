class CustomerSelfieCheckupMailer < ApplicationMailer

  def send_customer_diagnosis_mail(user, diagnosis_link)
    @user = user
    @diagnosis_link = diagnosis_link + '&utm_source=selfiecheckup&utm_medium=email&utm_campaign=email_sc_diagnosis_d0_v1'
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_diagnosis_d0_v1"] }.to_json

    mail( :to => @user.email, :subject => "The results are in! - Selfiecheckup" )
  end

  def send_customer_no_condition_mail(user)
    @user = user
    @general_skin_care_link = "https://remedicohealth.com/consult/patients/coupon_login?promo=CMAIL100&utm_source=selfiecheckup&utm_medium=email&utm_campaign=email_sc_no_condition_d0_v1&url=patients&condition=General%20Skin%20Care&name="+@user.name+"&mobile="+@user.mobile
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_no_condition_d0_v1"] }.to_json

    mail( :to => @user.email, :subject => "The results are in. Your skin is amazing!" )
  end

  def send_customer_bad_photo_mail(user)
    @user = user
    @selfie_checkup_link = "https://remedicohealth.com/consult/selfie_form?utm_source=selfiecheckup&utm_medium=email&utm_campaign=email_sc_bad_photo_d0_v1"
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_bad_photo_d0_v1"] }.to_json
    
    mail( :to => @user.email, :subject => "Oops! We want to see. how you look" )
  end

  def send_customer_recommend_consult_mail(selfie_form)
    @selfie_form = selfie_form
    @link = "https://remedicohealth.com/consult/patients/instant_login?p=" + encrypt(@selfie_form.patient) + "&utm_source=selfiecheckup&utm_medium=email&utm_campaign=email_sc_recommend_consult_d0_v1"
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_recommend_consult_d0_v1"] }.to_json

    mail( :to => @selfie_form.patient.email, :subject => "Hi #{@selfie_form.patient.name}, I've checked your selfie." )
  end

  def send_customer_recommend_visiting_a_doctor_mail(selfie_form)
    @selfie_form = selfie_form
    headers['X-SMTPAPI'] = { category: ["selfiecheckup", "sc_recommend_visiting_a_doctor_d0_v1"] }.to_json
    mail( :to => @selfie_form.patient.email, :subject => "Hi #{@selfie_form.patient.name}, I've checked your selfie." )
  end


end

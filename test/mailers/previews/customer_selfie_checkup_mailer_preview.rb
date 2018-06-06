# Preview all emails at http://localhost:3000/rails/mailers/customer_selfie_checkup_mailer
class CustomerSelfieCheckupMailerPreview < ActionMailer::Preview

  def send_customer_diagnosis_mail
    CustomerSelfieCheckupMailer.send_customer_diagnosis_mail(Patient.find(1419), 'https://54.255.145.215/consult/selfie-diagnosis?s=f4a6evmzWdjLdfv56rMtbA')
  end

  def send_customer_no_condition_mail
    CustomerSelfieCheckupMailer.send_customer_no_condition_mail(SelfieForm.find(66).patient)
  end

  def send_customer_bad_photo_mail
    CustomerSelfieCheckupMailer.send_customer_bad_photo_mail(Patient.find(93))
  end

  def send_customer_recommend_consult_mail
    CustomerSelfieCheckupMailer.send_customer_recommend_consult_mail(SelfieForm.find(96))
  end

  def send_customer_recommend_visiting_a_doctor_mail
    CustomerSelfieCheckupMailer.send_customer_recommend_visiting_a_doctor_mail(SelfieForm.find(67))
  end

end

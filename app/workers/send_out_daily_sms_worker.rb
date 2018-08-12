class SendOutDailySmsWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :low, :retry => 1

  def perform()
    puts "SIDEKIQ WORKER RUNNING"
    puts "DELIVER SMS"

    send_not_viewed_sms
    send_viewed_but_not_form_filled_sms
    send_viewed_form_filled_but_not_paid_sms
  end

  def send_not_viewed_sms
    # sms/email sent but the user HAS NOT VIEWED
    # day 3
    selfie_forms = SelfieForm.not_viewed.updated_between(-3, -3)
    selfie_forms.each do |selfie_form|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::HasNotViewed.day_3_sms(selfie_form.patient.name, selfie_form.diagnosis_link),
        mobile: selfie_form.patient.mobile,
        sms_type: 'sms_sc_diagnosis_not_viewed_d3_v1',
        patient_id: selfie_form.patient.id
      )
    end

    # day 5
    selfie_forms = SelfieForm.not_viewed.updated_between(-5, -5)
    selfie_forms.each do |selfie_form|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::HasNotViewed.day_5_sms(selfie_form.patient.name, selfie_form.diagnosis_link),
        mobile: selfie_form.patient.mobile,
        sms_type: 'sms_sc_diagnosis_not_viewed_d5_v1',
        patient_id: selfie_form.patient.id
      )
    end

    # day 7
    selfie_forms = SelfieForm.not_viewed.updated_between(-7, -7)
    selfie_forms.each do |selfie_form|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::HasNotViewed.day_7_sms(selfie_form.patient.name, selfie_form.diagnosis_link),
        mobile: selfie_form.patient.mobile,
        sms_type: 'sms_sc_diagnosis_not_viewed_d7_v1',
        patient_id: selfie_form.patient.id
      )
    end
  end

  def send_viewed_but_not_form_filled_sms
    # sms/email sent, user has viewed it, but hasn't filled the form
    # day 3
    patients = Patient.where(:id => SelfieForm.viewed.updated_between(-3, -3).select(:patient_id)).where.not(:id => Consultation.where.not(:user_status => ['form filled', 'free consultation done', 'red flag', 'payment failed', 'paid']).select(:patient_id))
    patients.each do |patient|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::ViewedButNoFF.day_3_sms(patient),
        mobile: patient.mobile,
        sms_type: 'sms_sc_diagnosis_viewed_no_ff_d3_v1',
        patient_id: patient.id,
      )
    end

    # day 7
    patients = Patient.where(:id => SelfieForm.viewed.updated_between(-7, -7).select(:patient_id)).where.not(:id => Consultation.where.not(:user_status => ['form filled', 'free consultation done', 'red flag', 'payment failed', 'paid']).select(:patient_id))
    patients.each do |patient|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::ViewedButNoFF.day_7_sms(patient),
        mobile: patient.mobile,
        sms_type: 'sms_sc_diagnosis_viewed_no_ff_d7_v1',
        patient_id: patient.id,
      )
    end
  end

  def send_viewed_form_filled_but_not_paid_sms
    # sms/email sent, user has viewed it, has filled the form, but hasn't paid
    # day 3
    consultations = Consultation.where("user_status similar to ?", "form filled|payment failed").where(:patient_id => SelfieForm.viewed.updated_between(-3, -3).select(:patient_id))
    consultations.each do |consultation|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::ViewedButNoFF.day_3_sms(consultation.patient),
        mobile: consultation.patient.mobile,
        sms_type: 'sms_sc_diagnosis_viewed_ff_d3_v1',
        patient_id: consultation.patient.id,
        consultation_id: consultation.id
      )
    end

    # day 7
    consultations = Consultation.where("user_status similar to ?", "form filled|payment failed").where(:patient_id => SelfieForm.viewed.updated_between(-7, -7).select(:patient_id))
    consultations.each do |consultation|
      SmsServiceController.sens_sms_new(
        message: SelfieDiagnosis::ViewedButNoFF.day_7_sms(consultation.patient),
        mobile: consultation.patient.mobile,
        sms_type: 'sms_sc_diagnosis_viewed_ff_d7_v1',
        patient_id: consultation.patient.id,
        consultation_id: consultation.id
      )
    end
  end

end

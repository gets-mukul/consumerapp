class SendOutSelfieDiagnosisWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :low, :retry => 1

  def perform()
    puts "RUNNING CRON JOB - SENDING OUT SELFIE CHECKUPS"

    # get all the diagnosed selfies
    selfie_forms = SelfieForm.where(:status => 'diagnosed')
    
    selfie_forms.each do |selfie_form|
      SmsServiceController.send_selfie_diagnosis_sms(selfie_form.id)
      if selfie_form.patient.email.present?
        CustomerSelfieCheckupMailer.send_customer_diagnosis_mail(selfie_form.patient, diagnosis_link).deliver_later()
        selfie_form.update(:status => 'diagonsed-sms-mailed')
      else
        selfie_form.update(:status => 'diagonsed-sms-no-email')
      end
    end

    # get all the unclear selfies
    selfie_forms = SelfieForm.where(:status => 'bad-photo')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerSelfieCheckupMailer.send_customer_bad_photo_mail(selfie_form.patient).deliver_later()
        selfie_form.update(:status => 'bad-photo-mailed')
      else
        selfie_form.update(:status => 'bad-photo-no-email')
      end
    end

    # get all the selfies with no issues
    selfie_forms = SelfieForm.where(:status => 'no-condition')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerSelfieCheckupMailer.send_customer_no_condition_mail(selfie_form.patient).deliver_later()
        selfie_form.update(:status => 'no-condition-mailed')
      else
        selfie_form.update(:status => 'no-condition-no-email')
      end
    end

    # get all the selfies with a consultation recommendation
    selfie_forms = SelfieForm.where(:status => 'recommend-consult')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerSelfieCheckupMailer.send_customer_recommend_consult_mail(selfie_form).deliver_later()
        selfie_form.update(:status => 'recommend-consult-mailed')
      else
        selfie_form.update(:status => 'recommend-consult-no-email')
      end
    end

        # get all the selfies with a consultation recommendation
    selfie_forms = SelfieForm.where(:status => 'recommend-visiting-a-doctor')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerSelfieCheckupMailer.send_customer_recommend_consult_mail(selfie_form).deliver_later()
        selfie_form.update(:status => 'recommend-visiting-a-doctor-mailed')
      else
        selfie_form.update(:status => 'recommend-visiting-a-doctor-no-email')
      end
    end
  end
end

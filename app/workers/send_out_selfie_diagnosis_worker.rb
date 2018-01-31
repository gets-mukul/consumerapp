class SendOutSelfieDiagnosisWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform()
    puts "RUNNING CRON JOB - SENDING OUT SELFIE CHECKUPS"

    # get all the diagnosed selfies
    selfie_forms = SelfieForm.where(:status => 'diagnosed')
    
    selfie_forms.each do |selfie_form|
      SmsServiceController.send_selfie_diagnosis_sms(selfie_form.id)
      if selfie_form.patient.email.present?
        CustomerNotifierMailer.send_selfie_diagnosis_mail(selfie_form.patient, selfie_form.diagnosis_link)
      end
    end

    # get all the unclear selfies
    selfie_forms = SelfieForm.where(:status => 'bad-photo')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerNotifierMailer.send_selfie_bad_photo_mail(selfie_form.patient)
        selfie_form.update(:status => 'bad-photo-mailed')
      else
        selfie_form.update(:status => 'bad-photo-no-email')
      end
    end

    # get all the selfies with no issues
    selfie_forms = SelfieForm.where(:status => 'no-condition')

    selfie_forms.each do |selfie_form|
      if selfie_form.patient.email.present?
        CustomerNotifierMailer.send_selfie_no_condition_mail(selfie_form.patient)
        selfie_form.update(:status => 'no-condition-mailed')
      else
        selfie_form.update(:status => 'no-condition-no-email')
      end
    end
  end
end

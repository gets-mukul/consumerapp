class SendOutSelfieDiagnosisWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform()
    puts "RUNNING CRON JOB - SENDING OUT SELFIE CHECKUPS"

    # get all the diagnosed selfies
    selfie_forms = SelfieForm.where(:status => 'diagnosed')
    
    selfie_forms.each do |selfie_form|
      SmsServiceController.send_selfie_diagnosis_sms(selfie_form.id)
      if patient.email.present?
        CustomerNotifierMailer.send_selfie_diagnosis_mail(selfie_form.patient, selfie_form.diagnosis_link)
      end
    end
    
  end
end

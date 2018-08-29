class DeliverSMSWorker
	include Sidekiq::Worker
	include SmsServiceHelper
	sidekiq_options :retry => false

	def perform(patient_id=nil, selfie_form_id=nil)
		puts "SIDEKIQ WORKER RUNNING"
		puts "DELIVER SMS"

		if selfie_form_id
			# day 0 viewed but no FF
			if (selfie_form = SelfieForm.where(:id => selfie_form_id).viewed.where.not(:patient_id => Consultation.where.not(:user_status => ['form filled', 'free consultation done', 'red flag', 'payment failed', 'paid']).select(:patient_id)))
				SmsServiceController.send_sms_new(
					message: SelfieDiagnosis::ViewedButNoFF.day_0_sms(selfie_form.patient),
					mobile: selfie_form.patient.mobile,
					sms_type: 'sms_sc_diagnosis_viewed_no_ff_d0_v1',
					patient_id: selfie_form.patient.id,
				)
			elsif (consultation = Consultation.where("user_status similar to ?", "form filled|payment failed").where(:patient_id => SelfieForm.where(:id => selfie_form_id).viewed.select(:patient_id)))
				SmsServiceController.send_sms_new(
					message: SelfieDiagnosis::ViewedButNoFF.day_0_sms(consultation.patient),
					mobile: consultation.patient.mobile,
					sms_type: 'sms_sc_diagnosis_viewed_ff_d0_v1',
					patient_id: consultation.patient.id,
					consultation_id: consultation.id
				)
			end
		elsif patient_id
			sent_sms = SmsService.where(patient_id: patient_id).where("created_at >= ?", DateTime.now-0.25)
			unless sent_sms.present?
				consultation = Consultation.where(patient_id: patient_id).where("consultations.created_at >= ?", DateTime.now-0.5).joins('LEFT JOIN selfie_forms on selfie_forms.patient_id=consultations.id').where("selfie_forms.patient_id is NULL").order('consultations.id desc')
				if consultation.present?
					latest_order = ["paid", "free consultation done", "payment failed", "processing", "form filled", "red flag", "registered"]
					sorted_consultation = consultation.sort_by{|x| latest_order.index x.user_status}[0]
					puts sorted_consultation.id
					if sorted_consultation.user_status.start_with?('form fill', 'payment failed', 'processing')
						SmsServiceController.send_sms(patient_id, "form filled", sorted_consultation.id)
					elsif sorted_consultation.user_status.start_with? 'register'
						SmsServiceController.send_sms(patient_id, "registered", sorted_consultation.id)
					end
				else
					SmsServiceController.send_sms(patient_id, "registered", "")
				end
				puts "DELIVERED SMS"
			end
		end
	end
end

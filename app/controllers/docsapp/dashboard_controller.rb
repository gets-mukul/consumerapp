class Docsapp::DashboardController < Docsapp::ApplicationController
    skip_before_action :verify_authenticity_token
    require 'urlsafe_encrypt'
    
    def index
    end
    
    def diagnose_selfie
        Rails.logger.info "Diagnosing selfies, doctor: #{current_doctor.short_name}"
        Rails.logger.info 'diagnosis start'
        @conditions = Condition.all
        # @selfie_forms = SelfieForm.where(:status => 'pending', :doctor => current_doctor).order('created_at desc')
        @selfie_forms = SelfieForm.where(:id => SelfieImage.select(:selfie_form_id), :status => 'pending', :doctor => current_doctor).order('created_at desc')

    end
    
    def save_condition
        Rails.logger.info "Saving diagnosis, doctor: #{current_doctor.short_name}"
        Rails.logger.info params
        selfie_form = SelfieForm.find(params["id"])
        if params["status"] == "diagnosed"
            conditions = Condition.where(key: params["conditions"])
            selfie_form.conditions.destroy_all
            selfie_form.conditions << conditions
            selfie_form.diagnosis_link = Rails.application.secrets.DOMAIN_NAME + "/consult/selfie-diagnosis?s=" + urlsafe_encrypt(selfie_form.id)
        end
        selfie_form.update({:status => params["status"]})
        unless params["status"].equal? 'bad-photo'
            current_doctor.increment!(:selfies_count, 1) 
        end
        render :json => { :value => "updated" }
    end

end

module PatientsHelper
  def current_user
    @current_user ||= Patient.find_by(id: session[:user_id])
  end

  def register user
    session[:user_id] = user.id
    session[:condition] = params[:condition]
    logger.info "Registered #{user.name}, condition: #{params[:condition]}"
    setup_patient_source
    DeliverSMSWorker.perform_in(1.hours, user.id) if Rails.env.production?
  end

  def unregister
    Rails.logger.info "In unregister"
    @current_user = nil
    @condition = nil
    reset_session
  end

  def register_selfie_checkup_user user
    session[:user_id] = user.id
    logger.info "Registered #{user.name} for selfie_checkup"
    setup_patient_source
  end

  def check_current_user
    if current_user.nil? and session[:condition].nil?
      redirect_to '/'
    end
  end

  def setup_patient_source
    # check if patient source is already stored
    existing_patient_source = PatientSource.where(patient_id: current_user.id).where("created_at >= ?", DateTime.now-0.02).order('id desc')
    unless existing_patient_source.present?
      # patient source does not exist, store them
      patient_source_params = {
        patient: current_user,
        local_referrer: (params[:referrer]||'').downcase,
        utm_campaign: (params[:utm_campaign]||'').downcase
      }
      patient_source = PatientSource.create(patient_source_params)
      session[:patient_source_id] = patient_source.id
      logger.info "Setting up utm campaign for #{patient_source_params}"
    end
  end
end

module PatientsHelper
  def current_user
    @current_user ||= Patient.find_by(id: session[:user_id])
  end

  def register user
    session[:user_id] = user.id
    session[:condition] = params[:condition]
    logger.info "Registered #{user.name}, condition: #{params[:condition]}"
    setup_patient_source
    DeliverSMSWorker.perform_in(1.hours, @patient.id) if Rails.env.production?
  end

  def unregister
    Rails.logger.debug { "In unregister" }
    @current_user = nil
    @condition = nil
    reset_session
  end

  def check_current_user
    if current_user.nil? and session[:condition].nil?
      redirect_to '/'
    end
  end

  def setup_patient_source
    patient_source_params = {
      patient: current_user,
      local_referrer: params[:referrer],
      utm_campaign: params[:utm_campaign]
    }
    PatientSource.create(patient_source_params)
    logger.info "Setting up utm campaign for #{patient_source_params}"
  end
end

module PatientsHelper
  def current_user
    @current_user ||= Patient.find_by(id: session[:user_id])
  end

  def register user
    session[:user_id] = user.id
    logger.info "Registered #{user.name}"
  end

  def unregister
    Rails.logger.debug { "In unregister" }
    @current_user = nil
    reset_session
  end
end

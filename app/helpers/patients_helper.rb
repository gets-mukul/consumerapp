module PatientsHelper
  def current_user
    @current_user ||= Patient.find_by(id: session[:user_id])
  end

  def register user
    session[:user_id] = user.id
    logger.info "Registered #{user.name}"
  end

  def unregister
    reset_session
    @current_user = nil
  end
end

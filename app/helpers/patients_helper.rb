module PatientsHelper
  def current_user
    @current_user ||= Patient.find_by(id: session[:user_id])
  end

  def register user
    session[:user_id] = user.id
    session[:condition] = params[:condition]
    logger.info "Registered #{user.name}, condition: #{params[:condition]}"
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

end

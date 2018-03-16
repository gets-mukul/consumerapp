module MyConsultationHelper
    
  def my_consultation
    @my_consultation ||= MyConsultation.find_by(id: session[:my_consultation_id])
  end
  
  def check_my_consultation
    if my_consultation.nil?
      redirect_to '/'
    end
  end

  def register_my_consultation my_consultation
    session[:my_consultation_id] = my_consultation.id
    session[:condition] = params[:condition]
  end

  def unregister_my_consultation
    @my_consultation = nil
    @condition_form = nil
    session[:promo_code] = nil
    reset_session
  end

end

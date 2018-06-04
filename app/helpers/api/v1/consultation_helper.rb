module Api::V1::ConsultationHelper

  def current_consultation
    @current_consultation ||= Consultation.find_by(id: session[:consultation_id])
  end

  def fetch_consultations
    # fetch his 3 latest consultations and pick the one thats first according to @@latest_order
    @consultation = Consultation.where(patient_id: current_user.id).order('created_at DESC').limit(3).sort_by{|x| Api::V1::ConsultationController.latest_order.index x.user_status}.first

    if @consultation.present?
      # consultation exists
      # show them the respective page
      session[:consultation_id] = @consultation.id
      if @consultation.user_status.start_with? 'registered'
        return { status: 'registered', condition: @consultation.category }
      elsif @consultation.user_status.start_with?('form filled', 'payment failed', 'processing')
        return { status: 'form_filled', condition: @consultation.category }
      end
    end

    # consultation doesn't exist. Choose a condition/load from session
    # if session[:condition]
      # render questionnaire
    # else
      return { status: 'new' }
    # end
  end

  def register_consultation consultation
    session[:consultation_id] = consultation.id
    session[:condition] = consultation.category
    if session[:patient_source_id]
      patient_source = PatientSource.find_by_id session[:patient_source_id]
      patient_source.update({consultation_id: consultation.id})
    end
    unless session[:promo_code].nil?
      coupon = Coupon.find_by coupon_code: session[:promo_code]
      if @consultation.coupon.nil? || (@consultation.coupon.discount_amount < coupon.discount_amount)
        @consultation.update({:amount => (350 - coupon.discount_amount), :coupon_id => coupon.id});
      end
    end
    logger.info "Registered #{consultation.patient.name}, condition: #{session[:condition]}"
  end

  def unregister_consultation
    Rails.logger.info "In unregister"
    @current_consultation = nil
  end

  def check_current_consultation
    if current_consultation.nil?
      render json: { status: 'unauthorized' }, status: :unauthorized
    end
  end

end

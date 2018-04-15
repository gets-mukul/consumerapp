module ConsultationHelper

  def current_consultation
    @current_consultation ||= Consultation.find_by(id: session[:consultation_id])
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
      redirect_to '/'
    end
  end

end

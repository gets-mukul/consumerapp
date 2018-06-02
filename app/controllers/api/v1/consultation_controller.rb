class Api::V1::ConsultationController < Api::V1::ApiController
  # skip_before_action :verify_authenticity_token, raise: false
  before_action :check_current_user
  
  def index
    # fetch his 3 latest consultations and pick the one thats first according to @@latest_order
    @consultation = Consultation.where(patient_id: current_user.id).order('created_at DESC').limit(3).sort_by{|x| Api::V1::ConsultationController.latest_order.index x.user_status}.first

    if @consultation.present?
      # consultation exists
      # show them the respective page
      if @consultation.user_status.start_with? 'registered'
        render json: { status: 'registered' }, status: :ok
        return
      elsif @consultation.user_status.start_with?('form filled', 'payment failed', 'processing')
        render json: { status: 'form_filled' }, status: :ok
        return
      end
    end

    # consultation doesn't exist. Choose a condition/load from session
    # if session[:condition]
      # render questionnaire
    # else
      render json: { status: 'new' }, status: :ok
    # end
  end


  private
    def self.latest_order
      @@latest_order = ["paid", "payment failed", "processing", "free consultation done", "form filled", "registered", "red flag"]
    end
end

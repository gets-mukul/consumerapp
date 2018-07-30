class Api::V1::ConsultationController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_action :check_current_user

  def get_consultations
    # fetch his 3 latest consultations and pick the one thats first according to @@latest_order
    @consultation = Consultation.where(patient_id: current_user.id).order('created_at DESC').limit(3).first

    if @consultation.present?
      # consultation exists
      # show them the respective page
      if @consultation.user_status.start_with?('registered', 'red flag')
        render json: {
          id: @consultation.id,
          status: 'registered',
          condition: @consultation.category,
          name: current_user.name,
          questionnaire_response: @consultation.questionnaire_response.present?
        }, status: :ok and return
      elsif @consultation.user_status.start_with?('form filled', 'payment failed', 'processing')
        render json: {id: @consultation.id, status: 'form_filled', condition: @consultation.category, name: current_user.name }, status: :ok and return
      end
    end

    render json: { status: 'new' }, status: :ok
  end

  def register
    @consultation = Consultation.where(:id => params[:id]).first
    if @consultation
      register_consultation @consultation
      render json: { status: "registered consultation" }, status: :ok
    else
      render json: { status: "couldn't find consultation" }, status: :not_found
    end
  end

  private
    def self.latest_order
      @@latest_order = ["paid", "payment failed", "processing", "free consultation done", "form filled", "registered", "red flag"]
    end
end

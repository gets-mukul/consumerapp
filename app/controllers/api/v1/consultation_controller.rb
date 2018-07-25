class Api::V1::ConsultationController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_action :check_current_user

  def get_consultations
    # fetch his 3 latest consultations and pick the one thats first according to @@latest_order
    @consultation = Consultation.where(patient_id: current_user.id).order('created_at DESC').limit(3).sort_by{|x| Api::V1::ConsultationController.latest_order.index x.user_status}.first

    if @consultation.present?
      # consultation exists
      # show them the respective page

      session[:consultation_id] = @consultation.id
      if @consultation.user_status.start_with?('registered', 'red flag')
        render json: {
          id: @consultation.id,
          status: 'registered',
          condition: @consultation.category,
          name: current_user.name,
          questionnaire_response: @consultation.questionnaire_response.present?
        }, status: :ok and return
      elsif @consultation.user_status.start_with?('form filled', 'payment failed', 'processing')
        render json: { id: @consultation.id, status: 'form_filled', condition: @consultation.category, name: current_user.name }, status: :ok and return
      end
    end

    render json: { status: 'new' }, status: :ok
  end

  private
    def self.latest_order
      @@latest_order = ["paid", "payment failed", "processing", "free consultation done", "form filled", "registered", "red flag"]
    end
end

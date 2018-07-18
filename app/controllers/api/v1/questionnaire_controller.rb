class Api::V1::QuestionnaireController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_filter :check_current_user

  def index
    unless current_consultation && current_consultation.user_status.start_with?('registered', 'red flag')
      @consultation = Consultation.create({
        patient: current_user,
        category: params[:condition]
      })
      register_consultation @consultation
    end

    render :json => {
      :questionnaire => Questionnaire.joins(:questionnaire_logics).where(questionnaire_logics: { name: params[:condition] }).select(:id, :question, :desc, :answers, :field_type, :variables, :image, :is_mandatory, :requires_check, :jump_logic, :static_params, :dynamic_params, :go_to, :save_checkpoint, :entry_type),
      :patient => {
        :name => current_user.name,
        :consultation_id => current_consultation.id,
        :questionnaire_response => (current_consultation.questionnaire_response ? current_consultation.questionnaire_response.responses : nil ),
      }
    }, :status => :ok
  end

end

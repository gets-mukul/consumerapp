class Api::V1::QuestionnaireController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_filter :check_current_user

  def index
    render :json => {
      :questionnaire => Questionnaire.joins(:questionnaire_logics).where(questionnaire_logics: { name: params[:condition] }).select(:id, :question, :desc, :answers, :field_type, :variables, :image, :is_mandatory, :requires_check, :jump_logic, :static_params, :dynamic_params, :go_to, :save_checkpoint, :entry_type),
      :patient => current_user.name
    }, :status => :ok
  end

end

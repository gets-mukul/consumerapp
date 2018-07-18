class Api::V1::QuestionnaireController < Api::V1::ApiController

  def index
    render :json => { :questionnaire => Questionnaire.joins(:questionnaire_logics).where(questionnaire_logics: { name: params[:condition] }).select(:id, :question, :desc, :answers, :field_type, :variables, :image, :is_mandatory, :requires_check, :jump_logic, :static_params, :dynamic_params, :go_to, :save_checkpoint, :entry_type), :status => :ok }
  end

end

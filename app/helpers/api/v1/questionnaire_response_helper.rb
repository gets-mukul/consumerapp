module Api::V1::QuestionnaireResponseHelper
  def questionnaire_response
    @questionnaire_response ||= QuestionnaireResponse.find_by(id: session[:questionnaire_response_id])
  end

  def check_questionnaire_response
    return (session[:questionnaire_response_id].present? && current_consultation.questionnaire_response.present?)
  end
end

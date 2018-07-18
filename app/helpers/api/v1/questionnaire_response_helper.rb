module Api::V1::QuestionnaireResponseHelper
  def questionnaire_response
    @questionnaire_response ||= QuestionnaireResponse.find_by(id: session[:questionnaire_response_id])
  end

  def check_questionnaire_response
    return (questionnaire_response.nil? and session[:questionnaire_response_id].nil?) || current_consultation.questionnaire_response.nil?
  end
end

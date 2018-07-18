class Api::V1::QuestionnaireResponseController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_filter :check_current_user
  include Api::V1::QuestionnaireResponseHelper


  def save
    session[:error_msgs] = {}
    if check_questionnaire_response
      unless current_consultation.questionnaire_response.update(:responses => params['responses'])
        session[:error_msgs]["QuestionnaireResponse#save - update existing consultation failed"] = current_consultation.errors.full_messages
      end
    else
      create(params['responses'])
    end

    if session[:error_msgs].present?
      AdminNotifierMailer.send_developer_error_email("Remedico: QuestionnaireResponse errors", session[:error_msgs].to_json).deliver_later
      session[:error_msgs] = nil
    end
    render :json => { message: 'saved successfully' }, :status => :ok
  end

  def create response
    @questionnaire_response = QuestionnaireResponse.new(
      :consultation => current_consultation,
      :responses => response,
      :category => 'Acne',
      :status => 'saved at checkpoint'
    )

    if @questionnaire_response.save
      session[:questionnaire_response_id] = @questionnaire_response.id
    else
      session[:error_msgs]["QuestionnaireResponse#save - create new questionnaire_response failed"] = @questionnaire_response.errors.full_messages
    end
  end

end

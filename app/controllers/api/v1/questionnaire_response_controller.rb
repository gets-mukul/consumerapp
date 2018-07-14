class Api::V1::QuestionnaireResponseController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token
  before_filter :check_current_user


  def save
    Rails.logger.info 'saving responses -------------------------'

    unless current_consultation

      @consultation = Consultation.create({
        patient: current_user,
        category: @condition
      })
      register_consultation @consultation
    end

    if current_consultation.questionnaire_response
      current_consultation.questionnaire_response(:responses => params['user_responses'])
    else
      create(response)
    end

    render :json => { message: 'saved successfully' }, :status => :ok
  end

  def create response
    Rails.logger.info response
    # questionnaire_responses = QuestionnaireResponse.new(
    #   :consultation => current_consultation,
    #   :responses => response,
    #   :category => 'Acne',
    #   :status => 'saved at checkpoint'
    # )
    # Rails.logger.info questionnaire_responses
    # unless questionnaire_responses.save
    #   Rails.logger.info questionnaire_responses.errors.full_messages
    # end
  end

end

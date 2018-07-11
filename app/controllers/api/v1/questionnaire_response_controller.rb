class Api::V1::QuestionnaireResponseController < Api::V1::ApiController
  skip_before_action :verify_authenticity_token

  def save
    Rails.logger.info 'saving responses -------------------------'
    Rails.logger.info params
    render :json => { message: 'created successfully' }, :status => :ok
  end

end

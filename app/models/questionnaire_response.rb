class QuestionnaireResponse < ApplicationRecord
  belongs_to :consultation
  has_many :questionnaire_response_images
end

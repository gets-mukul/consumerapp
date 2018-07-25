class QuestionnaireResponseImage < ApplicationRecord
  belongs_to :questionnaire_response
  validates_presence_of :image
end

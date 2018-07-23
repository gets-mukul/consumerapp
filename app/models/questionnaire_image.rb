class QuestionnaireImage < ApplicationRecord
  belongs_to :questionnaire_responses
  validates_presence_of :image
end

class SimpleQuizResponse < ApplicationRecord
  belongs_to :patient
  belongs_to :simple_quiz, optional: true
  belongs_to :diagnosis, optional: true
end

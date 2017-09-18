class PatientSource < ApplicationRecord
  belongs_to :patient
  validates_presence_of :patient
end

class PatientReferral < ApplicationRecord
  belongs_to :referrer,     :class_name => 'Patient'
  belongs_to :referee,      :class_name => 'Patient'
  belongs_to :consultation, :class_name => 'Consultation', optional: true
  
  after_initialize :set_defaults, unless: :persisted?
  
  def set_defaults
	  self.referrer_amount ||= 50
    self.referee_amount ||= 50
  end
end

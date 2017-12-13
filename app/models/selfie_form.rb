class SelfieForm < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true
  has_one :selfie_image
  has_and_belongs_to_many :conditions
  validates_presence_of :patient
  after_initialize :set_defaults, unless: :persisted?

  scope "Created today", -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
  scope "To be diagnosed", -> { where(status: 'pending') }
  scope "Unclear photos", -> { where(status: 'unclear') }
  scope "No conditions", -> { where(status: 'no-condition') }
  scope "To be sent out", -> { where(status: 'diagnosed') }
  scope "Sent", -> { where(status: 'sent') }
  
  def set_defaults
	  self.status ||= 'pending'
  end
end

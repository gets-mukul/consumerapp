class SelfieForm < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor, optional: true
  has_one :selfie_image
  has_and_belongs_to_many :conditions
  validates_presence_of :patient
  after_initialize :set_defaults, unless: :persisted?

  scope "Created today", -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
  scope "To be diagnosed", -> { where(status: 'pending') }
  scope "Unclear photos", -> { where("status like 'bad%'") }
  scope "No conditions", -> { where("status like 'no-cond%'") }
  scope "Diagnosed", -> { where("status like 'diag%'") }

  def set_defaults
	  self.status ||= 'pending'
  end
end

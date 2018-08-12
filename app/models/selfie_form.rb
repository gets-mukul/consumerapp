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
  scope "Diagnosis sent", -> { where("(status like 'diag%') and (status like '%sms%' or status like '%mail%') ") }
  scope :updated_between, lambda {|start_day, end_day| where('updated_at >= :start and updated_at < :end', :start => (start_day).days.from_now.beginning_of_day, :end   => (end_day+1).days.from_now.beginning_of_day)}
  scope :diagnosis_sent, -> { where("status similar to ?", "diag%(sms|mail)%") }
  scope :viewed, -> { where("status LIKE ?", "%-viewed%") }
  scope :not_viewed, -> { diagnosis_sent.where("status NOT LIKE ?", "%-viewed%") }

  def set_defaults
	  self.status ||= 'pending'
  end
end

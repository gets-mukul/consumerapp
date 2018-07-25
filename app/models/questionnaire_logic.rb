class QuestionnaireLogic < ApplicationRecord
  belongs_to :questionnaire
  validates_presence_of :questionnaire
  enum entry_type: [ :start, :end, :edit ]
  after_initialize :set_defaults, unless: :persisted?

  scope "Created today", -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }

  def set_defaults
    self.is_mandatory ||= false
    self.requires_check ||= false
    self.save_checkpoint ||= false
    self.name ||= 'Acne'
  end
end

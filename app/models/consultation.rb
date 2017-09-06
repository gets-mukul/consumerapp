class Consultation < ApplicationRecord
  belongs_to :patient
  validates_presence_of :user_status, :pay_status, :amount, :category, :patient

  after_initialize :set_defaults, unless: :persisted?
  
  def set_defaults
	self.amount ||= '350'
    self.pay_status ||= 'payment pending'
    self.user_status ||= 'registered'
  end

end

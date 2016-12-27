class Patient < ApplicationRecord
  alias_attribute :phone_no, :mobile
  after_initialize :set_defaults, unless: :persisted?
  has_many :payments

  def set_defaults
    self.pay_status ||= 'payment pending'
  end
end

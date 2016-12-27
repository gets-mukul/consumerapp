class Patient < ApplicationRecord
  alias_attribute :phone_no, :mobile
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.pay_status ||= 'payment pending'
  end
end

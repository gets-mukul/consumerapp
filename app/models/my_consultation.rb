class MyConsultation < ApplicationRecord
  belongs_to :coupon, optional: true
  alias_attribute :phone_no, :mobile
  #validates :email, :presence => true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :mobile, :presence => true,
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
	  self.email ||= ''
    self.amount ||= '350'
    self.pay_status ||= 'payment pending'
    self.user_status ||= 'registered'
  end
end

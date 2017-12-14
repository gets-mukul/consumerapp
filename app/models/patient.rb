class Patient < ApplicationRecord
  
  scope "Paid", -> { where(pay_status: 'paid') }
  scope "Free", -> { where(pay_status: 'free') }
  scope "Payment Pending", -> { where(pay_status: 'payment pending') }
  scope "Payment Failed", -> { where("pay_status like 'payment failed%'")}
  
  alias_attribute :phone_no, :mobile
  #validates :email, :presence => true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :mobile, :presence => true,
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
  after_initialize :set_defaults, unless: :persisted?
  has_many :payments
  
  def set_defaults
	  self.email ||= ''
    self.pay_status ||= 'payment pending'
  end
  
  def to_s
    self.name
  end
end

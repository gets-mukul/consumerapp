class Patient < ApplicationRecord
  alias_attribute :phone_no, :mobile
  #validates :email, :presence => true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :mobile, :presence => true,
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
  after_initialize :set_defaults, unless: :persisted?
  has_many :payments
  # has_and_belongs_to_many :coupons
  
  def set_defaults
	  self.email ||= ''
    self.pay_status ||= 'payment pending'
  end
end

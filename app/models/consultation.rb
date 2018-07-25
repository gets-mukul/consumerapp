class Consultation < ApplicationRecord
  belongs_to :patient
  belongs_to :coupon, optional: true
  belongs_to :doctor, optional: true
  has_one :questionnaire_response

  validates_presence_of :user_status, :pay_status, :amount, :category, :patient

  scope "Registered", -> { where(user_status: 'registered') }
  scope "Form filled", -> { where(user_status: 'form filled') }
  scope "Paid", -> { where(pay_status: 'paid') }
  scope "Free", -> { where(pay_status: 'free') }
  scope "Payment Failed", -> { where("pay_status like 'payment failed%'")}
  scope "Red Flags", -> { where("user_status like 'red flag%'")}

  # created between [from, to] ex: Consultation.created_between(-1, -1) => yesterday
  scope :created_between, lambda {|start_day, end_day| where('updated_at >= :start and updated_at < :end', :start => (start_day).days.from_now.beginning_of_day, :end   => (end_day+1).days.from_now.beginning_of_day)}

  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
	self.amount ||= '350'
    self.pay_status ||= 'payment pending'
    self.user_status ||= 'registered'
  end

  def to_s
    self.id
  end

end

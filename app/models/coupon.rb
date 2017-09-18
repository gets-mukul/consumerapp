class Coupon < ApplicationRecord
	# has_and_belongs_to_many :patient
	validates_presence_of :coupon_code, :status, :discount_amount, :count, :max_count 
	after_initialize :set_defaults, unless: :persisted?
	
	def set_defaults
		self.status ||= 'coupon unused'
	end
end

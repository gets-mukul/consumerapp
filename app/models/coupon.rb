class Coupon < ApplicationRecord
	validates_presence_of :coupon_code, :status, :discount_amount, :count, :max_count 
	after_initialize :set_defaults, unless: :persisted?
	
	scope "Used", -> { where(status: 'coupon used') }
	scope "Promos", -> { where("discount_amount < 350") }

	def set_defaults
		self.status ||= 'coupon unused'
	end
	
    def to_s
        self.coupon_code
    end
end

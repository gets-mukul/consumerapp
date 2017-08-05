class CreateCoupons < ActiveRecord::Migration[5.0]
	def change
		create_table :coupons do |t|
			t.column :coupon_code, :text, :null => false
			t.column :discount_amount, :float, :null => false
			t.column :status, :Boolean, :null => false
			t.column :expires_on, :timestamp
			
			t.belongs_to :patient, index: true, :null => true
			t.timestamps
		end

	end
end

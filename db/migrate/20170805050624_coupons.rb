class Coupons < ActiveRecord::Migration[5.0]
  def change
	create_table :coupons do |t|
		t.column :coupon_code, :text, :null => false
		t.column :discount_amount, :float, :null => false
		t.column :status, :string, :null => false
		t.column :expires_on, :timestamp
		t.column :count, :int, :null => false
		t.column :max_count, :int, :null => false
		
		t.timestamps
	end
  end
end

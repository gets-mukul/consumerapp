class CreateJoinTableCouponPatient < ActiveRecord::Migration[5.0]
  def change
    create_join_table :Coupons, :Patients do |t|
      # t.index [:coupon_id, :patient_id]
      # t.index [:patient_id, :coupon_id]
    end
  end
end

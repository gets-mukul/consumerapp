class CreateConsultations < ActiveRecord::Migration[5.0]
  def change
    create_table :consultations do |t|
      t.belongs_to :patient, index: true
      t.string :category
      t.string :user_status
      t.integer :amount, :limit => 2
      t.references :coupon, foreign_key: true, index: true
      t.string :pay_status

      t.timestamps
    end
  end
end

class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :txnid, null: false
      t.string :status, null: false
      t.string :desc, null: false
      t.string :amount, null: false
      t.string :add_charge
      t.string :mihpayid
      t.string :mode, null: false
      t.string :pg_type
      t.string :bank_ref_num
      t.belongs_to :patient, index: true

      t.timestamps
    end
  end
end

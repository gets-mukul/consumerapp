class CreateMyConsultations < ActiveRecord::Migration[5.0]
  def change
    create_table :my_consultations do |t|
      # patient
      t.string      :name,        null: false
      t.string      :mobile,      null: false
      t.string      :email
      t.integer     :age
      t.string      :sex
      t.string      :city

      # consultation
      t.string      :category
      t.string      :user_status
      t.string      :pay_status
      t.references  :coupon,      foreign_key: true,      index: true

      # payment
      t.integer     :amount,      :limit => 2
      t.string      :txnid
      t.string      :mode
      t.string      :pg_type
      t.string      :bank_ref_num

      # patient source
      t.string      :local_referrer
      t.string      :utm_campaign


      t.timestamps
    end
  end
end

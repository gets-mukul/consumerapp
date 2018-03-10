class CreatePatientReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_referrals do |t|

      t.belongs_to :referrer,      :class_name => "Patient"
      t.belongs_to :referee,       :class_name => "Patient"
      t.belongs_to :consultation,  :class_name => "Consultation"

      t.boolean :paid,             :default => false
      t.boolean :refunded,         :default => false
      
      t.integer :referrer_amount,  :limit => 2
      t.integer :referee_amount,   :limit => 2

      t.timestamps
    end
  end
end

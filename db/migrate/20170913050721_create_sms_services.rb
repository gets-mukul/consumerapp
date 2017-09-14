class CreateSmsServices < ActiveRecord::Migration[5.0]
  def change
    create_table :sms_services do |t|
      t.references :patient, foreign_key: true, index: true
      t.references :consultation, foreign_key: true, index: true
      t.string :sms_type
      t.string :sms_id
      t.string :status
      t.integer :detailed_status_code
      t.datetime :date_sent

      t.timestamps
    end
  end
end

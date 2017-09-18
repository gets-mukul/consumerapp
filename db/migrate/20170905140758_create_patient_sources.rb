class CreatePatientSources < ActiveRecord::Migration[5.0]
  def change
    create_table :patient_sources do |t|
      t.belongs_to :patient, index: true
      t.string :local_referrer
      t.string :utm_campaign

      t.timestamps
    end
  end
end

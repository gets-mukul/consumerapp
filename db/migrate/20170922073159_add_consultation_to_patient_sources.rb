class AddConsultationToPatientSources < ActiveRecord::Migration[5.0]
  def change
  	add_reference :patient_sources, :consultation, foreign_key: true
  end
end

class AddDoctorToConsultations < ActiveRecord::Migration[5.0]
  def change
    add_reference :consultations, :doctor, foreign_key: true
  end
end

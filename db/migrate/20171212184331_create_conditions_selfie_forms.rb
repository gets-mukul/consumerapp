class CreateConditionsSelfieForms < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions_selfie_forms do |t|
      t.references :selfie_form, foreign_key: true, index: true
      t.references :condition, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end

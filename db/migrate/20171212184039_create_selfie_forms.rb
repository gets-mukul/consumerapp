class CreateSelfieForms < ActiveRecord::Migration[5.0]
  def change
    create_table :selfie_forms do |t|
      t.belongs_to :patient, index: true
      t.column :content_type, :string
      t.column :desc, :string, limit: 140
      t.column :status, :string
      t.column :diagnosis_link, :string

      t.references :doctor, foreign_key: true, index: true
      
      t.timestamps
    end
    
    create_table :selfie_images do |t|
      t.belongs_to :selfie_form, index: true
      t.column :image, :string
      t.timestamps
    end
  end
end

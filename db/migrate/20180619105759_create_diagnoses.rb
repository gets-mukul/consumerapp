class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.column :category, :string
      t.column :sub_category, :string
      t.column :content, :jsonb
      t.timestamps
    end
  end
end

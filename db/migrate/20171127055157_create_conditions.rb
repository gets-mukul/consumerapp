class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.column :key, :string
      t.column :title, :string
      t.column :inline_desc, :string
      t.column :desc, :string
      
      t.timestamps
    end
  end
end

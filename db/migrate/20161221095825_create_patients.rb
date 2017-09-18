class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :mobile, null: false
      t.string :pay_status, null: false

      t.timestamps
    end
  end
end

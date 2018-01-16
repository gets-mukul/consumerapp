class AddColumnsToPatient < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :age, :integer
    add_column :patients, :sex, :string
    add_column :patients, :city, :string
  end
end

class RemoveNullConstraintFromPatient < ActiveRecord::Migration[5.0]
  def change
    change_column :patients, :email, :string, null: true
  end
end

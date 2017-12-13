class AddCodeToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :code, :string
  end
end

class AddReferrerToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :referrer, :string
  end
end

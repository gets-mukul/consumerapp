class AddColumnToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :mihpayid, :string
    add_column :patients, :mode, :string
    add_column :patients, :pg_type, :string
    add_column :patients, :bank_ref_num, :string
    add_column :patients, :c_id, :string, column_options: {null: false}
  end
end

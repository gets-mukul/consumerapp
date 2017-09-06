class AddConsultationToPayments < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :consultation, foreign_key: true
  end
end

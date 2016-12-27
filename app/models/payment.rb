class Payment < ApplicationRecord
  belongs_to :patient
  validates_presence_of :txnid, :status, :desc, :amount, :mode, :patient
end

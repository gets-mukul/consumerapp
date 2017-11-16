class Payment < ApplicationRecord
  belongs_to :patient
  belongs_to :consultation
  validates_presence_of :txnid, :status, :desc, :amount, :patient

  scope "Paid", -> { where(status: 'paid') }

end

class SmsService < ApplicationRecord
  validates_presence_of :sms_id, :sms_type
end

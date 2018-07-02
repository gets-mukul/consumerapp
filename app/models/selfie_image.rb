class SelfieImage < ApplicationRecord
  belongs_to :selfie_form
  validates_presence_of :image
  # mount_uploader :image, SelfieImageUploader
end

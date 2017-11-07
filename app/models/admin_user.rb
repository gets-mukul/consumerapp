class AdminUser < ApplicationRecord
  
  enum role: [:regular, :admin, :marketing]
  after_initialize :set_defaults, :if => :new_record?
  
  def set_defaults
    self.role ||= :regular
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
        :recoverable, :rememberable, :trackable, :validatable

end

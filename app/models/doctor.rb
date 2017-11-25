class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def short_name
    'Dr. ' << self.first_name
  end

  def full_name
    'Dr. ' << self.first_name << ' ' << self.last_name
  end
  
end

class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, "registerable", :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    "Dr. #{first_name}"
  end

  def short_name
    "Dr. #{first_name}"
  end

  def full_name
    "Dr. #{first_name} #{last_name}"
  end

end

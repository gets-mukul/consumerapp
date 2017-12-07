class Condition < ApplicationRecord

  def to_s
    self.key
  end

end
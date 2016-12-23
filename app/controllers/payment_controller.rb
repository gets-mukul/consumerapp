class PaymentController < ApplicationController
  def index
    unless current_user
      redirect_to '/new_patient'
    end
  end

  def success
    @patient = Patient.find_by_name current_user.name
    @patient.update({pay_status: "paid"})
  end
end

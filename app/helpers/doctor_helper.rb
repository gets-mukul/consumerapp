module DoctorHelper
  
  def current_doctor
    @current_doctor ||= Doctor.find session[:current_doctor_id]
  end

  def assign_consultation_to_doctor consultation
    current_doctor = Doctor.find(fetch_latest_doctor)
    Rails.logger.info "Doctor Helper: Assigning #{current_doctor.first_name} to Consultation##{consultation.id}"
    consultation.update(:doctor => current_doctor)
    current_doctor.consultations_count += 1
    current_doctor.save
  end
  
  def fetch_current_doctor
    Rails.logger.info "Doctor Helper: Fetch current doctor initiated by Consultation##{session[:consultation_id]}"
    unless session[:current_doctor_id]
      # store the current doctor in session
      session[:current_doctor_id] = fetch_latest_doctor
    end
  end
  
  def fetch_latest_doctor
    Rails.logger.info "Doctor Helper: Finding the current doctor for Consultation##{session[:consultation_id]}"
    # set the order in which the doctors have to be assigned
    doctor_order = ['Sonam', 'Gaurangi', 'Ankita', 'Abhishek']
    # get previously assigned doctor
    prev = Consultation.where(:pay_status => 'paid').order('updated_at').last.doctor
    # get the doc's index from the doctor_order
    curr_idx = prev ? doctor_order.find_index(prev.first_name) : -1
    # make an empty varialbe
    next_doctor = nil
    # find the next available doctor
    loop do
      curr_idx += 1;
      curr_idx = 0 if curr_idx == doctor_order.length
      next_doctor = Doctor.find_by(:first_name => doctor_order[curr_idx])
      if next_doctor.available_for_consultation?
        $last_doctor_consulted = next_doctor.id
        break
      end
    end
    Rails.logger.info "Doctor Helper: Set current doctor #{next_doctor.first_name} to Consultation##{session[:consultation_id]}"
    return next_doctor.id
  end
  
end

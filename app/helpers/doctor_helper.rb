module DoctorHelper
  
  def matched_consultation_doctor
    @matched_consultation_doctor ||= Doctor.find session[:matched_consultation_doctor_id]
  end

  def assign_consultation_to_doctor consultation
    matched_consultation_doctor = Doctor.find(fetch_latest_doctor)
    Rails.logger.info "Doctor Helper: Assigning #{matched_consultation_doctor.first_name} to Consultation##{consultation.id}"
    consultation.update(:doctor => matched_consultation_doctor)
    matched_consultation_doctor.consultations_count += 1
    matched_consultation_doctor.save
  end
  
  def fetch_matched_consultation_doctor
    Rails.logger.info "Doctor Helper: Fetch matched_consultation_doctor initiated by Consultation##{session[:consultation_id]}"
    unless session[:matched_consultation_doctor_id]
      # store the matched_consultation_doctor in session
      session[:matched_consultation_doctor_id] = fetch_latest_doctor
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
    Rails.logger.info "Doctor Helper: Set matched_consultation_doctor #{next_doctor.first_name} to Consultation##{session[:consultation_id]}"
    return next_doctor.id
  end
  
  def allocate_docs_to_selfies
    Rails.logger.info "Allocating doctors to selfies"
    # get all available doctors
    doctors = Doctor.where(:available_for_selfie_checkup => true)
    # get all the pending selfies
    pending_selfies = SelfieForm.where('doctor_id is null')
    # extract the pending selfies
    pending_selfie_ids = pending_selfies.pluck(:id)

    selfie_chunks = pending_selfie_ids.each_slice(doctors.length).to_a
    if selfie_chunks[doctors.length].present?
      selfie_chunks[doctors.length-1] += selfie_chunks[doctors.length]
      selfie_chunks.delete_at doctors.length
    end

    doctors.zip(selfie_chunks).each do |doctor, selfies|
      pending_selfies.where(id: selfies).update_all(:doctor_id => doctor.id)
    end

    Rails.logger.info "Doctor Helper: Set matched_consultation_doctor #{next_doctor.first_name} to Consultation##{session[:consultation_id]}"
  end
end

class AllocateDoctorsToSelfiesWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform()
    puts "RUNNING CRON JOB - ALLOCATING DOCTORS TO SELFIES"

    # get all available doctors
    doctors = Doctor.where(:available_for_selfie_checkup => true)
    # get all the pending selfies
    pending_selfies = SelfieForm.where('doctor_id is null')
    # extract the pending selfies
    pending_selfie_ids = pending_selfies.pluck(:id)
    # break it into #doctors chunks
    selfie_chunks = pending_selfie_ids.each_slice(doctors.length).to_a
    # if there's an odd remainder add it to the final chunk
    if selfie_chunks[doctors.length].present?
      selfie_chunks[doctors.length-1] += selfie_chunks[doctors.length]
      selfie_chunks.delete_at doctors.length
    end
    
    # allocate chunks to doctors
    doctors.zip(selfie_chunks).each do |doctor, selfies|
      pending_selfies.where(id: selfies).update_all(:doctor_id => doctor.id)
    end
    
  end
end
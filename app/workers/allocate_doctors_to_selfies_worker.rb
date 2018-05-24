class AllocateDoctorsToSelfiesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :low, :retry => 2

  def perform()
    puts "RUNNING CRON JOB - ALLOCATING DOCTORS TO SELFIES"

    # get all available doctors
    doctors = Doctor.order("RANDOM()").where(:available_for_selfie_checkup => true)
    # get all the pending selfies
    pending_selfies = SelfieForm.where('doctor_id is null')
    # extract the pending selfie ids
    pending_selfie_ids = pending_selfies.pluck(:id)
    # break it into #doctors chunks
    
    if pending_selfie_ids.size > 0
      selfie_chunks = pending_selfie_ids.each_slice( (pending_selfie_ids.size/doctors.length.to_f).ceil ).to_a

      # allocate chunks to doctors
      doctors.zip(selfie_chunks).each do |doctor, selfies|
        pending_selfies.where(id: selfies).update_all(:doctor_id => doctor.id)
      end
    end
  end
end

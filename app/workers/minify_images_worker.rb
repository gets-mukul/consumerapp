class MinifyImagesWorker
  include Sidekiq::Worker
  include S3BucketImageResize
  sidekiq_options :retry => false

  def perform(patient_id: nil, selfie_form_id: nil)
    puts "SIDEKIQ WORKER RUNNING"
    puts "MINIFY IMAGES"
    read_sqs_messages
  end
end

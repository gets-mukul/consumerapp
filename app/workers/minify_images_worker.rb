class MinifyImagesWorker
  include Sidekiq::Worker
  include S3BucketImageResize
  sidekiq_options :retry => false

  def perform(*args)
    puts "SIDEKIQ WORKER RUNNING"
    puts "MINIFY IMAGES"
    read_sqs_messages
  end
end

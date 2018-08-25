module S3BucketImageResize
  require 'aws-sdk'
  require "mini_magick"

  S3_BUCKET = Rails.application.secrets.S3_BUCKET
  SQS_REGION = Rails.application.secrets.SQS_REGION
  SQS_URL = Rails.application.secrets.SQS_URL
  AWS_ACCESS_KEY_ID = Rails.application.secrets.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = Rails.application.secrets.AWS_SECRET_ACCESS_KEY

  def read_sqs_messages
    sqs = Aws::SQS::Client.new(
      region: SQS_REGION,
      access_key_id: AWS_ACCESS_KEY_ID,
      secret_access_key: AWS_SECRET_ACCESS_KEY
    )
    resp = sqs.receive_message(queue_url: SQS_URL, max_number_of_messages: 10)
    puts resp.length
    resp.messages.each do |message_raw|
      message = message_raw
      response = JSON.parse(message.body)
      url = response["Records"].first["s3"]["object"]["key"]

      compressed_file_path = compress_image_from_s3 "https://s3-ap-southeast-1.amazonaws.com/#{ENV['S3_BUCKET']}/#{url}"
      upload_compressed_image_to_s3 url, compressed_file_path
      delete_sqs_message sqs, message_raw.receipt_handle
      FileUtils.rm_f(compressed_file_path)
    end
    return
  end

  def delete_sqs_message sqs, receipt_handle
    # delete sql message once it is read
    resp = sqs.delete_message({
      queue_url: SQS_URL, # required
      receipt_handle: receipt_handle, # required
    })
  end

  def compress_image_from_s3 url
    # code to compres image
    image = MiniMagick::Image.open(url)
    image.resize("320x320")
    image.write "output.#{image.type.downcase}"
    "output.#{image.type.downcase}"
  end

  def upload_compressed_image_to_s3 url, file
    # code to upload compressed image to s3
    s3 = Aws::S3::Resource.new(
      region: SQS_REGION,
      AWS_ACCESS_KEY_ID: AWS_ACCESS_KEY_ID,
      secret_access_key: AWS_SECRET_ACCESS_KEY
    )
    url.sub! '/image/', '/image-min/'
    s3.bucket(ENV["S3_BUCKET"]).object(url).upload_file(file, {:acl => 'public-read'})
  end

end

CarrierWave.configure do |config|
  
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => Rails.application.secrets.AWS_ACCESS_KEY_ID,             # required
    :aws_secret_access_key  => Rails.application.secrets.AWS_SECRET_ACCESS_KEY,         # required
    :region                 => 'ap-southeast-1'                   # optional, defaults to 'us-east-1'
  }
  
  config.fog_directory  = 'remedico-bucket-1'                     # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  
  # Use AWS storage if in production else use local storage
  if Rails.env.production?
    config.storage = :fog
  else
    config.storage = :file
  end
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

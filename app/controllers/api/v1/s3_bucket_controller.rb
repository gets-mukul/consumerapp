class Api::V1::S3BucketController < Api::V1::ApiController
  include Api::V1::AwsHelper
  
  def get_s3_policy
    render json: RemedicoS3.post_data_for_images(params[:folder_name]), status: :ok
  end

end

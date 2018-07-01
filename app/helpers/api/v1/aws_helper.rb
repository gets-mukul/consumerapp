module Api::V1::AwsHelper
  require 'aws-sdk'
  
  class RemedicoS3
    def self.post_data_for_images folder_name
      s3 = Aws::S3::Resource.new :region => 'ap-southeast-1'
      bucket = s3.bucket('remedico-test')
      
      
      post_helper = DirectPostHelper.new bucket
      folder = "uploads/#{folder_name}/"
      Rails.logger.info folder
      # custom_params = {'content-type' => 'image/*', 'acl' => 'public-read'}
      custom_params = {'acl' => 'public-read'}

      policy = post_helper.generate_policy
      custom_params.each_pair{|k, v| policy.exact_condition k, v}
      policy.fit_in_condition 'starts-with', '$Content-Type', 'image/'
      policy.fit_in_condition 'starts-with', '$key', folder
      policy.fit_in_condition 'content-length-range', 1, 10485760

      {
          url: bucket.url,
          folder: folder,
          params: post_helper.generate_params(policy, custom_params)
      }
    end

    class DirectPostHelper

      def initialize(bucket)
        @bucket = bucket
        @time_iso8601 = Time.zone.now.utc.strftime '%Y%m%dT%H%M%SZ'
      end

      def generate_policy(expire_in=2.hours)
        policy = PostPolicy.new expire_in
        policy.exact_condition 'x-amz-algorithm', 'AWS4-HMAC-SHA256'
        policy.exact_condition 'x-amz-date', @time_iso8601
        policy.exact_condition 'x-amz-credential', credential
        policy.exact_condition 'Cache-Control', 'max-age=31536000'
        policy.exact_condition 'bucket', @bucket.name
        policy.exact_condition 'success_action_status', '201'
        policy
      end

      def generate_params(policy, params={})
        params.merge! 'x-amz-signature' => signature(policy),
                      'policy' => policy.encoded,
                      'x-amz-algorithm' => 'AWS4-HMAC-SHA256',
                      'x-amz-date' => @time_iso8601,
                      'x-amz-credential' => credential,
                      'Cache-Control' => 'max-age=31536000',
                      'success_action_status' => '201'
      end

      private

      def credential
        [
            @bucket.client.config.credentials.access_key_id,
            @time_iso8601[0,8],
            @bucket.client.config.region,
            's3',
            'aws4_request'
        ] * '/'
      end

      def signature(policy)
        k_date = hmac("AWS4#{@bucket.client.config.credentials.secret_access_key}", @time_iso8601[0,8])
        k_region = hmac(k_date, @bucket.client.config.region)
        k_service = hmac(k_region, 's3')
        k_credentials = hmac(k_service, 'aws4_request')
        hexhmac(k_credentials, policy.encoded)
      end

      def hmac(key, value)
        OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, value)
      end

      def hexhmac(key, value)
        OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), key, value)
      end

      class PostPolicy

        def initialize(expire_in)
          @expire_time = Time.zone.now.utc + expire_in
          @conditions = []
        end

        def exact_condition(value_name, arg)
          @conditions << {value_name => arg}
        end

        def fit_in_condition(value_name, arg1, arg2)
          @conditions << [value_name, arg1, arg2]
        end

        def encoded
          hash = {
              'expiration' => @expire_time.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
              'conditions' => @conditions
          }
          Base64.encode64(hash.to_json).gsub("\n","")
        end

      end

    end
  end
end
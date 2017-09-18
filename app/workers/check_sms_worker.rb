class CheckSmsWorker
  require 'net/http'
  require 'net/https'
  require 'uri'
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(smsid)
    puts "SIDEKIQ GET SMS STATUS"  
    begin
      
      uri = URI('https://api.exotel.com/v1/Accounts/'+Rails.application.secrets.EXOTEL_SID+'/SMS/Messages/'+smsid+'.json')

      response = ""
      Net::HTTP.start(uri.host, uri.port,
        :use_ssl => uri.scheme == 'https',
        :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

        request = Net::HTTP::Get.new uri.request_uri
        request.basic_auth Rails.application.secrets.EXOTEL_SID, Rails.application.secrets.EXOTEL_TOKEN

        json = http.request request
        response = JSON.parse(json.body)
      end

      @sms = SmsService.find_by :sms_id => smsid
      
      @sms.update({detailed_status_code: response["SMSMessage"]["DetailedStatusCode"], status: response["SMSMessage"]["Status"], date_sent: response["SMSMessage"]["DateSent"]})

    rescue JSON::ParserError, TypeError => e
      logger.info "SMS SENT BUT UNABLE TO PARSE"
    end
  end
end

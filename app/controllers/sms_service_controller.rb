class SmsServiceController < ApplicationController
  require 'update_sheets'
  require 'encrypt'
  require 'net/http'
  require 'uri'

  # usage: message_body("Kelly", "paid")
  def self.message_body(patient_id, template, consultation_id)
    case template
      when "registered"
        patient = Patient.find_by_id patient_id
        login_link = "bit.do/rme?p=" + encrypt(patient)
        sms = "Hi, thanks for checking out Remedico! Continue your consultation here: #{login_link} If you have any questions, WhatsApp us at 8433848969 - Remedico"
        return sms
      when "form filled"
        consultation = Consultation.find_by_id consultation_id
        payment_link = "bit.do/rmpay?p=" + encrypt(consultation)
        name = consultation.patient.name.split[0]
        sms = "Hi #{name}! Thanks for trying out Remedico! You filled in a questionnaire but we didn't receive the payment. To get your treatment plan from our dermatologists within 24 hours, click here to pay #{payment_link} Questions? whatsapp us at 8433848969"
        return sms
      when "paid"
        return "Thanks for using Remedico! Our dermatologists are reviewing your case and if everything is in order, you can expect a treatment plan within 24 hours - Remedico"
      else
        return ""
      end

  end

  def self.send_sms(patient_id, template, consultation_id)
    puts "IN SEND SMS"

    message = SmsServiceController.message_body(patient_id, template, consultation_id)
    puts "MSGS"
    logger.info message

    patient = Patient.find_by_id patient_id
    consultation = Consultation.find_by_id consultation_id

    if message.present?
      uri = URI.parse("https://api.exotel.com/v1/Accounts/"+Rails.application.secrets.EXOTEL_SID+"/Sms/send.json")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(Rails.application.secrets.EXOTEL_SID, Rails.application.secrets.EXOTEL_TOKEN);
      request.body = "From=02233756413&To="+patient.mobile+"&Body="+message

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      json = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      response = ""
      response = JSON.parse(json.body)

      @sms = SmsService.create({
        patient_id: patient.id,
        sms_type: template,
        sms_id: response["SMSMessage"]["Sid"],
        detailed_status_code: response["SMSMessage"]["DetailedStatusCode"],
        status: response["SMSMessage"]["Status"],
        date_sent: response["SMSMessage"]["DateSent"]
      })
      @sms.update({consultation_id: consultation.id}) if consultation.present?

      CheckSmsWorker.perform_in(15.minutes, @sms.sms_id)

    end
    
  end
end


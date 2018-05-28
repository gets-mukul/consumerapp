class SmsServiceController < ApplicationController
  require 'encrypt'
  require 'net/http'
  require 'uri'

  # usage: message_body("Kelly", "paid")
  def self.message_body(patient, template, consultation)
    case template
    when "registered"
      login_link = "https://bit.do/rmlgn?p=" + encrypt(patient)
      sms = "Hi, thanks for checking out Remedico! Continue your consultation here: #{login_link} If you have any questions, WhatsApp us at 8433848969"
      return sms
    when "form filled"
      payment_link = "https://bit.do/rempy?p=" + encrypt(consultation)
      name = patient.name.split[0]
      sms = "Hi #{name}! Thanks for trying out Remedico! You filled in a questionnaire but we didn't receive the payment. To get your treatment plan from our dermatologists within 24 hours, click here to pay #{payment_link} Questions? whatsapp us at 8433848969"
      return sms
    when "paid"
      return "Thanks for using Remedico! Our dermatologists are reviewing your case and if everything is in order, you can expect a treatment plan within 24 hours - Remedico"
    when "paid_check_if_started"
      name = patient.name.split[0]
      sms = "Hey #{name}, just checking if you've started ur treatment plan. If you've got problems with ur treatment plan, click https://bit.do/wtpp to msg us"
      return sms
    when "paid_follow_up"
      name = patient.name.split[0]
      sms = "Hey #{name}, a quick reminder that your follow-up is due. Don't worry follow-ups are just Rs.100. Just msg us on https://bit.do/flwp when you're ready"
      return sms
    else
      return ""
    end
  end

  def self.send_sms(patient_id, template, consultation_id)
    puts "< IN SEND SMS >"

    patient = Patient.find_by_id patient_id
    consultation = Consultation.find_by_id consultation_id

    message = SmsServiceController.message_body(patient, template, consultation)
    puts "< MESSAGE >"

    if message.present?
      uri = URI.parse("https://api.exotel.com/v1/Accounts/"+Rails.application.secrets.EXOTEL_SID+"/Sms/send.json")
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(Rails.application.secrets.EXOTEL_SID, Rails.application.secrets.EXOTEL_TOKEN);
      request.body = "From=02233756413&To="+patient.mobile+"&Body="+message

      req_options = {
        use_ssl: uri.scheme == "https",
      }
      begin
        json = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        response = ""
        response = JSON.parse(json.body)

        @sms = SmsService.new({
          patient_id: patient.id,
          sms_type: template
        })
        unless response["SMSMessage"].nil?
          @sms.assign_attributes({
            sms_id: response["SMSMessage"]["Sid"],
            detailed_status_code: response["SMSMessage"]["DetailedStatusCode"],
            status: response["SMSMessage"]["Status"],
            date_sent: response["SMSMessage"]["DateSent"]
          })
        end
        @sms.consultation_id = consultation.id if consultation.present?
        @sms.save!
      rescue
      end
    end
  end

  # usage: message_body("Kelly", 1234)
  def self.selfie_diagnosis_message_body(name, selfie_link)
    login_link = "https://bit.do/rmselfie?s=" + selfie_link.split('=').last
    sms = "Hi #{name}! Your selfie diagnosis is ready. Check it out at #{login_link} -Team Remedico"
    return sms
  end

  def self.send_selfie_diagnosis_sms(selfie_id)
    selfie_form = SelfieForm.find(selfie_id)
    message = SmsServiceController.selfie_diagnosis_message_body(selfie_form.patient.name.split[0], selfie_form.diagnosis_link)
    puts "SENDING SELFIE SMS >"
    uri = URI.parse("https://api.exotel.com/v1/Accounts/"+Rails.application.secrets.EXOTEL_SID+"/Sms/send.json")
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(Rails.application.secrets.EXOTEL_SID, Rails.application.secrets.EXOTEL_TOKEN);
    request.body = "From=02233756413&To="+selfie_form.patient.mobile+"&Body="+message

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    json = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response = ""
    response = JSON.parse(json.body)

    @sms = SmsService.new({
      patient_id: selfie_form.patient.id,
      sms_type: "selfie diagnosis"
    })
    unless response["SMSMessage"].nil?
      @sms.assign_attributes({
        sms_id: response["SMSMessage"]["Sid"],
        detailed_status_code: response["SMSMessage"]["DetailedStatusCode"],
        status: response["SMSMessage"]["Status"],
        date_sent: response["SMSMessage"]["DateSent"]
      })
      selfie_form.update({status: 'diagonsed-sms'})
    end
    @sms.save!
  end
end

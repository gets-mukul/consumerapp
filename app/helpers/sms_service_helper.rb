module SmsServiceHelper
  extend ActiveSupport::Concern
  require 'encrypt'

  class SelfieDiagnosis

    module HasNotViewed
      class << self

        def day_0_sms(name, link)
          "Hi #{SmsServiceHelper.shorten_name(name)}! Your selfie diagnosis is ready. Check it out at #{day_n_sms_link(0, link)} -Remedico"
        end

        def day_3_sms(name, link)
          "Hi #{SmsServiceHelper.shorten_name(name)}! Got a chance to check ur selfie checkup diagnosis yet? Click #{day_n_sms_link(3, link)} to check it out -Remedico"
        end

        def day_5_sms(name, link)
          "Hey #{SmsServiceHelper.shorten_name(name)}, your skin diagnosis is ready! Learn what the doctors had to say about your skin - #{day_n_sms_link(5, link)} -Remedico"
        end

        def day_7_sms(link)
          "Not checked ur selfie checkup diagnosis yet? Start ur process to better skin by viewing ur diagnosis #{day_n_sms_link(7, link)} -Remedico"
        end

        private
          def day_n_sms_link nth_day, link
            "https://bit.do/scnv#{nth_day.to_s}?s=#{link.split('=').last}"
          end
      end
    end

    module ViewedButNoFF
      class << self

        def day_0_sms patient
          "Hey #{SmsServiceHelper.shorten_name(patient.name)}! Now that you've checked ur diagnosis, take ur first steps towards great skin & hair by consulting our doctors online - #{day_n_sms_link(0, patient)} -Remedico"
        end

        def day_3_sms patient
          "We really want to help you get better skin and hair. So here’s Rs.100 off your treatment plan - #{day_n_sms_link(3, patient)} -Remedico"
        end

        def day_7_sms patient
          "Hey #{SmsServiceHelper.shorten_name(patient.name)}! Did u know that our dermatologists personalize ur treatment plan? Get your treatment plan today - #{day_n_sms_link(7, patient)} -Remedico"
        end

        private
          def day_n_sms_link nth_day, patient
            "https://bit.do/scvnf#{nth_day.to_s}?p=#{encrypt(patient)}"
          end
      end
    end

    module ViewedAndFF
      class << self

        def day_0_sms patient
          "Hi #{SmsServiceHelper.shorten_name(patient.name)}! Thanks for trying out Remedico! You filled in a questionnaire but we didn't receive the payment. To get ur treatment plan from our dermatologists within %d hours, click here to pay #{day_n_sms_link(0, patient)} Questions? whatsapp us at 8433848969"
        end

        def day_3_sms patient
          "We really, REALLY want to help you get better skin and hair. So here’s Rs.100 off ur treatment plan - #{day_n_sms_link(3, patient)} -Remedico"
        end

        def day_7_sms patient
          "Ur treatment plan is almost ready! Did u know that our dermatologists personalize ur treatment plan? Get urs today - #{day_n_sms_link(7, patient)} -Remedico"
        end

        private
          def day_n_sms_link nth_day, patient
            "https://bit.do/scvf#{nth_day.to_s}?p=#{encrypt(patient)}"
          end
      end
    end
  end

  def self.shorten_name name
    name.split.first
  end

end

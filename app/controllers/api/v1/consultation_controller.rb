class Api::V1::ConsultationController < Api::V1::ApiController
  # skip_before_action :verify_authenticity_token, raise: false
  # before_action :check_current_user


  private
    def self.latest_order
      @@latest_order = ["paid", "payment failed", "processing", "free consultation done", "form filled", "registered", "red flag"]
    end
end

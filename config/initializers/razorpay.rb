require 'razorpay'

Razorpay.setup(Rails.application.secrets.RAZOR_PAY_KEY_ID, Rails.application.secrets.RAZOR_PAY_KEY_SECRET)
Razorpay.headers = {"CUSTOM_APP_HEADER" => "Remedico"}

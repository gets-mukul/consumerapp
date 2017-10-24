# Load the Rails application.
require_relative 'application'

ActionMailer::Base.smtp_settings = {
  :user_name => Rails.application.secrets.SENDGRID_USERNAME,
  :password => Rails.application.secrets.SENDGRID_PASS,
  :domain => 'remedicohealth.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

# Initialize the Rails application.
Rails.application.initialize!

if Rails.env.production?
	Rails.logger = Le.new(Rails.application.secrets.LE_RAILS_TOKEN, :debug => true, :local => true)
end

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
Rails.logger = Le.new('bd157c97-dcc9-488d-bfba-31d1cab4e1e7', :debug => true, :local => true)


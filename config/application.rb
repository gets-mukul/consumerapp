require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Remedica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.prefix = "/consult/assets"
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.action_mailer.asset_host = Rails.application.secrets.DOMAIN
    config.time_zone = 'Kolkata'
    config.active_record.default_timezone = :local
    config.active_job.queue_adapter = Rails.env.production? ? :sidekiq : :async
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_caching = true
  end
end

Sidekiq.configure_server do |config|
  config.redis = {url: 'redis://localhost:6379/0', network_timeout: 25}

  if ENV['SIDEKIQ_CRON'] == 'true'
    schedule_file = "config/schedule.yml"

    if File.exists?(schedule_file) && Sidekiq.server?
      Sidekiq::Cron::Job.load_from_hash! YAML.load_file(schedule_file)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = {url: 'redis://localhost:6379/0', network_timeout: 25}
end

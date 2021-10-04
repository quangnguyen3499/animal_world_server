Sidekiq.configure_server do |config|
  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1"), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
    schedule_file = "config/schedule.yml"

    Sidekiq::Status.configure_server_middleware config, expiration: 30.minutes
    Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes

    if File.exists?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
  
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1"), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }

    Sidekiq::Status.configure_client_middleware config, expiration: 30.minutes
  end
end

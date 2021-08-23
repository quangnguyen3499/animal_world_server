Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local = false

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.active_storage.service = :local

  config.log_level = :debug

  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = {host: ENV["HOST"]}

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  config.action_mailer.smtp_settings = {
    user_name: ENV["EMAIL_USERNAME"],
    password: Rails.application.credentials.mailer[:sendgrid_api_key],
    address: ENV["SMTP_ADDRESS"],
    domain: ENV["SMTP_DOMAIN"],
    port: ENV["SMTP_PORT"],
    authentication: ENV["SMTP_AUTHENTICATION"],
    enable_starttls_auto: true
  }
end

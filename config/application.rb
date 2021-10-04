require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module RailsBaseApi
  class Application < Rails::Application
    config.load_defaults 6.0

    config.api_only = true

    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths += ["#{Rails.root}/lib/api"]

    config.time_zone = "Asia/Tokyo"

    config.active_record.default_timezone = :utc

    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*",
          headers: :any,
          expose: ["access-token", "expiry", "token-type", "uid", "client",
            "Origin", "Content-Type", "Content-MD5", "Content-Disposition"],
          methods: [:get, :post, :options, :delete, :put, :patch]
      end
    end

    config.middleware.use Rack::Attack

    config.i18n.default_locale = :en

    config.paths.add "app/serializers/concerns", eager_load: true
    config.middleware.use ActionDispatch::Cookies

    # Middleware for ActiveAdmin
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Session::CookieStore
  end
end

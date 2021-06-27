Devise.setup do |config|
  config.reconfirmable = false # change email without reconfirmation
  config.mailer_sender = ENV["EMAIL_SUPPORTER"]
  config.reset_password_within = 72.hours
  config.mailer = "DeviseMailer"
  require "devise/orm/active_record"
end

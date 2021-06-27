class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_SUPPORTER"]
  layout "mailer"
end

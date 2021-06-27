class DeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  default template_path: "devise/mailer"

  def confirmation_instructions record, token, opts = {}
    @token = token
    devise_mail(record, :confirmation_instructions, opts)
  end

  def reset_password_instructions record, token, opts = {}
    @init = opts[:init] || false
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end
end

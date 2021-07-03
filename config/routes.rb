Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq/cron/web"
  require "sidekiq-status/web"
  mount Sidekiq::Web => "/sidekiq"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.in?(%w(development staging))
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      mount_devise_token_auth_for "CompanyAdmin", at: "company_admins", skip: [:omniauth_callbacks], controllers: {
        sessions: "api/v1/company_admins/sessions",
        registrations: "api/v1/company_admins",
        passwords: "api/v1/clients/passwords"
      }
      mount_devise_token_auth_for "Client", at: "clients", skip: [:omniauth_callbacks], controllers: {
        sessions: "api/v1/clients/sessions",
        registrations: "api/v1/clients",
        passwords: "api/v1/clients/passwords"
      }
    end
  end
end
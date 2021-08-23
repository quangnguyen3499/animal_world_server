Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq/cron/web"
  require "sidekiq-status/web"
  mount Sidekiq::Web => "/sidekiq"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.in?(%w(development staging))
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      mount_devise_token_auth_for "User", at: "users", skip: [:omniauth_callbacks], controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations",
        passwords: "api/v1/users/passwords"
      }
      resources :animals
    end
  end
end
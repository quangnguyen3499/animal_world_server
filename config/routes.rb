Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  require "sidekiq/web"
  require "sidekiq/cron/web"
  require "sidekiq-status/web"
  mount Sidekiq::Web => "/sidekiq"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.in?(%w(development))
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      mount_devise_token_auth_for "User", at: "users", skip: [:omniauth_callbacks], controllers: {
        sessions: "api/v1/users/sessions",
        registrations: "api/v1/users/registrations",
        passwords: "api/v1/users/passwords"
      }
      resources :users
      resources :shops
      resources :coordinates
      resources :statistics
      resources :floors
      resources :markers
      get "/shortest_path", to: "statistics#find_shortest_path"
    end
  end
end
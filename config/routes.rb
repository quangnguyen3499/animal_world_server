Rails.application.routes.draw do
  devise_for :clients
  devise_for :company_admins
  require "sidekiq/web"
  require "sidekiq/cron/web"
  require "sidekiq-status/web"
  mount Sidekiq::Web => "/sidekiq"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.in?(%w(development staging))
  namespace :api do
    namespace :v1, defaults: {format: :json} do
    end
  end
end
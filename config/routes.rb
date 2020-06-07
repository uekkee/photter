require "sidekiq/web"

Rails.application.routes.draw do
  resources :images, only: %i(index)

  mount Sidekiq::Web => "/sidekiq"
end

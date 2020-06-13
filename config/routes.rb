require 'sidekiq/web'

Rails.application.routes.draw do
  resources :images, only: %i(index)

  namespace :api, format: 'json' do
    resources :images, only: :index
  end

  mount Sidekiq::Web => '/sidekiq'
end

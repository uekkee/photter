# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'image_searches#index'

  resources :image_searches, only: %i[index]
  resources :images, only: %i[index destroy]
  resources :tags, only: %i[index destroy]
  resource :bulk_register_image, only: %i[create]

  namespace :api, format: 'json' do
    resources :images, only: :index
  end

  mount Sidekiq::Web => '/sidekiq'
end

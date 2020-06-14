# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :images, only: %i[index]
  resource :site_design, only: :show

  namespace :api, format: 'json' do
    resources :images, only: :index
  end

  mount Sidekiq::Web => '/sidekiq'
end

# frozen_string_literal: true

Unsplash.configure do |config|
  config.application_access_key = Rails.application.credentials.unsplash[:access_key]
  config.application_secret = Rails.application.credentials.unsplash[:secret_key]
  config.utm_source = 'photter-demo'
  # config.application_redirect_uri = "https://your-application.com/oauth/callback"
end

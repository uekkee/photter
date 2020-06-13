# frozen_string_literal: true

VCR.configure do |config|
  config.ignore_localhost = true
  config.ignore_hosts 'chromedriver.storage.googleapis.com'
  config.default_cassette_options = { match_requests_on: %i[method path query], record: :new_episodes }
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock

  config.register_request_matcher :auth_header do |request_1, request_2|
    request_1.headers['Authorization'] == request_2.headers['Authorization']
  end

  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end

  config.filter_sensitive_data('<ACCESS_KEY>') { Unsplash.configuration.application_access_key }
  config.filter_sensitive_data('<APP_SECRET>') { Unsplash.configuration.application_secret }
  config.filter_sensitive_data('<UTM_SOURCE>') { Unsplash.configuration.utm_source }
  config.filter_sensitive_data('<BEARER_TOKEN>') { ENV['UNSPLASH_BEARER_TOKEN'] }
  config.filter_sensitive_data('<API_URI>') { ENV.fetch('UNSPLASH_API_URI', 'https://api.unsplash.com/') }
  config.filter_sensitive_data('<OAUTH_URI>') { ENV.fetch('UNSPLASH_OAUTH_URI', 'https://unsplash.com/') }
end

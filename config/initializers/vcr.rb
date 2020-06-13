return unless Rails.env.development? && ENV.fetch("ENABLE_VCR", 0).to_i.positive?

# if using VCR on development, we need patch for Webpacker::DevServerProxy
# see: https://github.com/rails/webpacker/issues/1474#issuecomment-498502741

require "rack/proxy"

class Webpacker::DevServerProxy < Rack::Proxy

  def perform_request(env)
    if env["PATH_INFO"].start_with?("/#{public_output_uri_path}") && Webpacker.dev_server.running?
      scheme = "http#{Webpacker.dev_server.https? ? 's' : ''}"
      uri = "#{scheme}://#{Webpacker.dev_server.host_with_port}#{env["PATH_INFO"]}"
      request = Net::HTTP::Get.new(uri)

      response = Net::HTTP.start(Webpacker.dev_server.host, Webpacker.dev_server.port) do |http|
        http.request(request)
      end

      headers = {}
      response.each_header do |k, v|
        headers[k] = v unless k == "transfer-encoding" || (k == "content-length" && Webpacker.dev_server.https?)
      end

      [response.code.to_i, headers, [response.read_body]]
    else
      @app.call(env)
    end
  end

  private
    def public_output_uri_path
      Webpacker.config.public_output_path.relative_path_from(Webpacker.config.public_path)
    end
end

# VCR settings for unsplash API
VCR.configure do |config|
  config.ignore_localhost = true
  config.default_cassette_options = { match_requests_on: [:method, :path, :query], record: :new_episodes }
  config.cassette_library_dir = "tmp/cassettes"
  config.hook_into :webmock

  config.register_request_matcher :auth_header do |request_1, request_2|
    request_1.headers["Authorization"] == request_2.headers["Authorization"]
  end

  config.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end

  config.filter_sensitive_data("<ACCESS_KEY>") { Unsplash.configuration.application_access_key }
  config.filter_sensitive_data("<APP_SECRET>") { Unsplash.configuration.application_secret }
  config.filter_sensitive_data("<UTM_SOURCE>") { Unsplash.configuration.utm_source }
  config.filter_sensitive_data("<BEARER_TOKEN>") { ENV["UNSPLASH_BEARER_TOKEN"] }
  config.filter_sensitive_data("<API_URI>") { ENV.fetch("UNSPLASH_API_URI", "https://api.unsplash.com/") }
  config.filter_sensitive_data("<OAUTH_URI>") { ENV.fetch("UNSPLASH_OAUTH_URI", "https://unsplash.com/") }
end

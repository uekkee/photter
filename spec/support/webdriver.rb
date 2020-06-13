# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    if ENV.fetch('HEADLESS_E2E', nil).to_i.positive?
      driven_by :selenium_chrome_headless, screen_size: [1600, 1600] do
        driver_options.add_argument('--disable-dev-sim-usage')
        driver_options.add_argument('--no-sandbox')
      end
    end
  end
end

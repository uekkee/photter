# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseRewinder.clean_all
  end

  config.after(:each) do
    # TODO: fix database_rewinder works well on Rails 7
    DatabaseRewinder.clean_all
  end
end

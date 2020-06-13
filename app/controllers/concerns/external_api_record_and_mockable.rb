# frozen_string_literal: true

module ExternalApiRecordAndMockable
  extend ActiveSupport::Concern

  included do
    around_action :with_vcr if vcr_enabled?
  end

  def with_vcr
    VCR.use_cassette 'default' do
      yield
    end
  end

  module ClassMethods
    def vcr_enabled?
      Rails.env.development? && ENV.fetch('ENABLE_VCR', 0).to_i.positive?
    end
  end
end

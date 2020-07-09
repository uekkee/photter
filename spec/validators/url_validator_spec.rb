# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlValidator, type: :model do
  subject { model_class.new(url) }

  let(:model_class) do
    Struct.new(:url) do
      include ActiveModel::Validations

      def self.name
        'DummyModel'
      end

      validates :url, url: true
    end
  end

  context 'valid url' do
    let(:url) { 'https://localhost.localdomain' }
    it { is_expected.to be_valid }
  end

  context 'invalid url' do
    let(:url) { 'zzhttps://localhost.localdomain' }
    it { is_expected.to be_invalid }
  end

  context 'blank' do
    let(:url) { '' }
    it { is_expected.to be_valid }
  end
end

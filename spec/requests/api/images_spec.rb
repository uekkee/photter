# frozen_string_literal: true

require 'rails_helper'

describe 'resources images', type: :request do
  describe '#index' do
    subject { get api_images_path, params: { q:, page: 1 } }

    around do |example|
      VCR.use_cassette 'photos' do
        example.run
      end
    end

    context 'valid params' do
      let(:q) { 'dog' }
      it do
        subject
        json = JSON.parse(response.body).symbolize_keys
        expect(json).to match a_hash_including(total: 21_069, total_pages: 703)
        expect(json[:images].count).to eq 30
      end
    end

    context 'invalid params' do
      let(:q) { '' }
      it do
        subject
        json = JSON.parse(response.body).symbolize_keys
        expect(json).to match a_hash_including(total: 0, total_pages: 0, images: [])
      end
    end
  end
end

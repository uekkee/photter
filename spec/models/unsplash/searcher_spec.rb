# frozen_string_literal: true

require 'rails_helper'

describe Unsplash::Searcher, type: :model do
  describe '#search' do
    subject { Unsplash::Searcher.new(params).search }

    around do |example|
      VCR.use_cassette 'photos' do
        example.run
      end
    end

    context 'with valid params' do
      let(:params) { { q: 'dog', page: '1' } }
      it do
        expect(subject.images.count).to eq 30
        expect(subject.total).to eq 21_069
        expect(subject.total_pages).to eq 703
      end
    end

    context 'with invalid params' do
      let(:params) { {} }
      it do
        expect(subject.images).to be_empty
        expect(subject.total).to be_zero
        expect(subject.total_pages).to be_zero
      end
    end
  end
end

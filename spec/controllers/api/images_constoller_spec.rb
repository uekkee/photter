# frozen_string_literal: true

require 'rails_helper'

describe Api::ImagesController, type: :controller do
  describe '#index' do
    subject { get :index, params: params.merge(format: 'json') }

    around do |example|
      VCR.use_cassette 'photos' do
        example.run
      end
    end

    context 'with valid params' do
      let(:params) { { q: 'dog', page: '1' } }
      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:search_result).images.count).to eq 30
      end
    end

    context 'with invalid params' do
      let(:params) { {} }
      it do
        expect(subject).to have_http_status :ok
        expect(assigns(:search_result).images.count).to be_zero
      end
    end
  end
end

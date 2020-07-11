# frozen_string_literal: true

require 'rails_helper'

describe BulkRegisterImagesController, type: :controller do
  describe '#create' do
    subject { post :create, params: { bulk_register: params } }

    let(:params) do
      {
        image_urls: [image_url],
        tag_names: tag_names,
      }
    end
    let(:image_url) { 'https://localhost.localdomain/cat.jpg' }
    let(:tag_names) { %w[cat kitty huge] }

    it do
      expect { subject }.to have_enqueued_job(RegisterImageWithTagsJob)
        .with(image_url: image_url, tag_names: tag_names)
      expect(subject).to have_http_status :no_content
    end
  end
end

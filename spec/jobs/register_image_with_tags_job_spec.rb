# frozen_string_literal: true

require 'rails_helper'

describe RegisterImageWithTagsJob, type: :job do
  subject { RegisterImageWithTagsJob.perform_now(image_url: image_url, tag_names: tag_names) }

  let(:image_url) { 'https://localhost.localdomain/fat_dog.png' }
  let(:tag_names) { %w[dog fat] }

  it 'delegates Image.register_image_with_names' do
    expect { subject }.to change { Image.count }.to(1)
    image = Image.first
    expect(image).to have_attributes url: image_url
    expect(image.tags.map(&:name)).to match_array tag_names
  end
end

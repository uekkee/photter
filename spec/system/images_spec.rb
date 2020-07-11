# frozen_string_literal: true

require 'rails_helper'

describe 'images', type: :system do
  around do |example|
    VCR.use_cassette 'photos' do
      example.run
    end
  end

  let!(:hotdog_image) { create :image, tags: [create(:tag, name: 'hotdogs')] }
  let!(:catalina_image) { create :image, tags: [create(:tag, name: 'catalina')] }

  it 'search and destroy image' do
    visit images_path

    expect(page).to have_content hotdog_image.tags.first.name
    expect(page).to have_content catalina_image.tags.first.name

    fill_in with: "dog\n"

    expect(page).to have_content hotdog_image.tags.first.name
    expect(page).not_to have_content catalina_image.tags.first.name

    accept_confirm do
      click_link href: Rails.application.routes.url_helpers.image_path(hotdog_image)
    end

    expect(page).to have_content 'Image destroyed'
    expect(Image.count).to eq 1
  end
end

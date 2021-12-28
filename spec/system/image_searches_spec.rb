# frozen_string_literal: true

require 'rails_helper'

describe 'images', type: :system do
  around do |example|
    VCR.use_cassette 'photos' do
      example.run
    end
  end

  let(:expected_image_url) do
    'https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE0MDY5OX0&utm_source=photter-demo&utm_medium=referral&utm_campaign=api-credit'
  end
  let(:tag_names) { %w[dog puppy] }

  it 'search images and register single image' do
    visit image_searches_path

    fill_in with: "dog\n"

    # select images
    all('figure.image')[0].click

    # show modal
    click_on 'Take selected image(s) into DB!'

    within('.modal-card') do
      expect(all('figure.image').size).to eq 1
      tag_names.each { |tag_name| fill_in with: "#{tag_name}\n" }
      expect(all('span.tag').size).to eq 2

      click_on 'Take!'
      expect(page).to have_content 'Succeeded! It may take a few seconds to applying to our DB'
    end

    expect(RegisterImageWithTagsJob).to have_been_enqueued
      .with(image_url: expected_image_url, tag_names:)
  end

  it 'search images and register images' do
    visit image_searches_path

    fill_in with: "dog\n"

    # select images
    all('figure.image')[0].click
    all('figure.image')[1].click

    # show modal
    click_on 'Take selected image(s) into DB!'

    within('.modal-card') do
      expect(all('figure.image').size).to eq 2
      tag_names.each { |tag_name| fill_in with: "#{tag_name}\n" }
      expect(all('span.tag').size).to eq 2

      click_on 'Take!'
      expect(page).to have_content 'Succeeded! It may take a few seconds to applying to our DB'
    end

    expect(RegisterImageWithTagsJob).to have_been_enqueued.twice
  end
end

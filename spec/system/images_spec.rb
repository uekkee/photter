# frozen_string_literal: true

require 'rails_helper'

describe 'images', type: :system do
  around do |example|
    VCR.use_cassette 'photos' do
      example.run
    end
  end

  it do
    visit images_path

    # select images
    all('figure.image')[0].click
    all('figure.image')[1].click

    # show modal
    click_on 'Take selected image(s) into DB!'

    within('.modal-card') do
      expect(all('figure.image').size).to eq 2
      fill_in with: "dog\n"
      fill_in with: "puppy\n"
      expect(all('span.tag').size).to eq 2
    end
  end
end

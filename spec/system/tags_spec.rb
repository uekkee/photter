# frozen_string_literal: true

require 'rails_helper'

describe 'tags', type: :system do
  around do |example|
    VCR.use_cassette 'photos' do
      example.run
    end
  end

  let!(:hotdog_tag) { create :tag, name: 'hotdog' }
  let!(:catalina_tag) { create :tag, name: 'catalina' }

  it 'see and destroy tag' do
    visit tags_path

    expect(page).to have_link href: tag_path(hotdog_tag)
    expect(page).to have_link href: tag_path(catalina_tag)

    accept_confirm do
      click_link href: tag_path(hotdog_tag)
    end

    expect(page).to have_content 'Tag destroyed'
    expect(Tag.count).to eq 1
  end
end

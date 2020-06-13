require 'rails_helper'

describe 'images', type: :system do
  it do
    visit images_path

    expect(page).to have_content 'still WIP'
  end
end

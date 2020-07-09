# frozen_string_literal: true

require 'rails_helper'

describe Image, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:image_tags).inverse_of(:image).dependent(:delete_all) }
    it { is_expected.to have_many(:tags).through(:image_tags).inverse_of(:images) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
    it { is_expected.to validate_url_of(:url) }
  end
end

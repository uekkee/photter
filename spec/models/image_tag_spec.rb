# frozen_string_literal: true

require 'rails_helper'

describe ImageTag, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:image).inverse_of(:image_tags) }
    it { is_expected.to belong_to(:tag).inverse_of(:image_tags) }
  end
end

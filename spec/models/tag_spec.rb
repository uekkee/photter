# frozen_string_literal: true

require 'rails_helper'

describe Tag, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:image_tags).inverse_of(:tag).dependent(:delete_all) }
    it { is_expected.to have_many(:images).through(:image_tags).inverse_of(:tags) }
  end
end

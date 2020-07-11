# frozen_string_literal: true

require 'rails_helper'

describe Tag, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:image_tags).inverse_of(:tag).dependent(:delete_all) }
    it { is_expected.to have_many(:images).through(:image_tags).inverse_of(:tags) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'scope' do
    describe '.name_like' do
      subject { Tag.name_like keywords }

      let(:keywords) { %w[dog cat] }
      let(:match_records) do
        [
          create(:tag, name: 'hotdogs'),
          create(:tag, name: 'catalina'),
        ]
      end
      let(:not_match_record) { create :tag, name: 'bird' }

      before do
        match_records
        not_match_record
      end

      it { is_expected.to match_array match_records }
    end
  end
end

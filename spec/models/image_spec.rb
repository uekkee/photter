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

  describe "#apply_tags_by_name" do
    subject { image.apply_tags_by_name tag_names }

    let(:image) { create :image }
    let(:tag_names) { %w(dog pretty puppy) }
    let!(:exist_tag) { create :tag, name: 'dog' }

    it do
      subject
      expect(image.tags).to include exist_tag
      expect(image.tags.map(&:name)).to match_array tag_names
    end

    it do
      expect { subject }.to change { Tag.count }.from(1).to(3)
    end
  end
end

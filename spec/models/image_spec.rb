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

  describe '#apply_tags_by_name' do
    subject { image.apply_tags_by_name tag_names }

    let(:image) { create :image }
    let(:tag_names) { %w[dog pretty puppy] }
    let!(:exist_tag) { create :tag, name: 'dog' }

    context 'image without tag' do
      it do
        subject
        expect(image.tags).to include exist_tag
        expect(image.tags.map(&:name)).to match_array tag_names
      end
      it do
        expect { subject }.to change { Tag.count }.from(1).to(3)
      end
    end

    context 'image with tag' do
      let(:image) { create :image, tags: [bird_tag] }
      let(:bird_tag) { create :tag, name: 'bird' }
      it 'tags are overwritten' do
        subject
        expect(image.tags).not_to include bird_tag
        expect(image.tags.map(&:name)).to match_array tag_names
      end
    end
  end

  describe '.register_with_tag_names' do
    subject { Image.register_with_tag_names image_url:, tag_names: }

    let(:image_url) { 'https://localhost.localdomain/dog.jpg' }
    let(:tag_names) { %w[cat cool kitty] }

    context 'no same image_url' do
      it do
        expect { subject }.to change { Image.count }.to(1)
        image = Image.first
        expect(image).to have_attributes url: image_url
        expect(image.tags.map(&:name)).to match_array tag_names
      end
    end

    context 'has same image_url already' do
      let(:image) { create :image, url: image_url }
      it do
        expect { subject }.to change { image.tags.count }.from(0).to(3)
        expect(image.tags.map(&:name)).to match_array tag_names
      end
    end

    context 'invalid url' do
      let(:image_url) { 'not a url' }
      it { expect { subject }.to raise_error ActiveRecord::RecordInvalid }
    end
  end
end

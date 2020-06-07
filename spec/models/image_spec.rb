require "rails_helper"

describe Image, type: :model do
  describe "association" do
    it { is_expected.to have_many(:image_tags).inverse_of(:image) }
    it { is_expected.to have_many(:tags).through(:image_tags) }
  end
end
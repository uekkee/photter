# frozen_string_literal: true

require "rails_helper"

describe Unsplash::Searcher, type: :model do
  describe "#search" do
    subject { Unsplash::Searcher.new(params).search }

    around do |example|
      VCR.use_cassette "photos" do
        example.run
      end
    end

    context "with valid params" do
      let(:params) { { q: "dog", page: "1" } }
      it { expect(subject.count).to eq 10 }
    end

    context "with invalid params" do
      let(:params) { {} }
      it { expect(subject.count).to be_zero }
    end
  end
end
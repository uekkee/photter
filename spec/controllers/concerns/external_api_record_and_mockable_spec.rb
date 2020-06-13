# frozen_string_literal: true

require "rails_helper"

describe ExternalApiRecordAndMockable, type: :controller do
  controller ApplicationController do
    include ExternalApiRecordAndMockable

    # on development env, around_action is set automatically on included
    around_action :with_vcr

    def index
      head :no_content
    end
  end

  describe "#with_vcr" do
    subject { get :index }

    it do
      expect(VCR).to receive(:use_cassette).with("default")
      subject
    end
  end

  describe ".vcr_enabled?" do
    subject { controller.class.vcr_enabled? }

    context "default" do
      it { is_expected.to be_falsey }
    end

    context "development and ENABLE_VCR=1" do
      before do
        allow(Rails.env).to receive(:development?) { true }
        allow(ENV).to receive(:fetch).with("ENABLE_VCR", 0) { "1" }
      end

      it { is_expected.to be_truthy }
    end
  end
end


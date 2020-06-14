# frozen_string_literal: true

class SiteDesignsController < ApplicationController
  include ExternalApiRecordAndMockable

  def show
    @images = Unsplash::Searcher.new(q: 'dog').search
  end
end

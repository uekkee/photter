# frozen_string_literal: true

class Api::ImagesController < ApplicationController
  include ExternalApiRecordAndMockable

  def index
    @search_result = Unsplash::Searcher
                     .new(searcher_params)
                     .search
  end

  private

  def searcher_params
    params.permit(:q, :page)
  end
end

# frozen_string_literal: true

class Api::ImagesController < ApplicationController
  include ExternalApiRecordAndMockable

  def index
    @images = Unsplash::Searcher
                .new(searcher_params)
                .search
    render json: @images
  end

  private

  def searcher_params
    params.permit(:q, :page)
  end
end
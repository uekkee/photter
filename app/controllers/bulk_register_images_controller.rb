# frozen_string_literal: true

class BulkRegisterImagesController < ApplicationController
  def create
    create_params[:image_urls].each do |image_url|
      RegisterImageWithTagsJob.perform_later image_url: image_url, tag_names: create_params[:tag_names]
    end
  end

  private

  def create_params
    params.require(:bulk_register).permit(image_urls: [], tag_names: [])
  end
end

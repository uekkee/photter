# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    @images = match_images
              .order(:id)
              .preload(:tags)
              .page(params[:page])
  end

  def destroy
    image.destroy!
    redirect_to images_path, notice: 'Image destroyed'
  end

  private

  def match_images
    keywords = params[:q]&.split
    if keywords.present?
      Image
        .distinct
        .joins(:tags)
        .merge(Tag.name_like(keywords))
    else
      Image.all
    end
  end

  def image
    @image ||= Image.find(params[:id])
  end
end

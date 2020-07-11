# frozen_string_literal: true

class ImagesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render_images_html }
      format.csv { render_csv }
    end
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
        .order(:id)
    else
      Image.all
    end
  end

  def render_images_html
    @images = match_images
                .preload(:tags)
                .page(params[:page])
  end

  def render_csv
    csv_data = CSV.generate(write_headers: true) do |csv|
      csv << %w(url tags)
      match_images.preload(:tags).each do |image|
        csv << [image.url, image.tags.map(&:name).join(',')]
      end
    end

    send_data csv_data, filename: 'images.csv'
  end

  def image
    @image ||= Image.find(params[:id])
  end
end

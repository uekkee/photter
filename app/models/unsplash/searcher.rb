# frozen_string_literal: true

class Unsplash::Searcher
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :q, :string
  attribute :page, :integer, default: 1

  validates :q, presence: true
  validates :page, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def search
    search_result = search_from_unsplash if valid?
    build_result_object search_result
  end

  private

  def build_result_object(search_result)
    OpenStruct.new(
      {
        total: search_result&.total || 0,
        total_pages: search_result&.total_pages || 0,
        images: search_result&.map { |result| parse_single_result result } || []
      }
    )
  end

  def search_from_unsplash
    Unsplash::Photo
      .search(q, page, 30)
  end

  def parse_single_result(result)
    {
      image_url: result.urls.regular,
      thumbnail_url: result.urls.thumb
    }
  end
end

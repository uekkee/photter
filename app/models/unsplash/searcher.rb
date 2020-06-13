# frozen_string_literal: true

class Unsplash::Searcher
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :q, :string
  attribute :page, :integer, default: 1

  validates :q, presence: true
  validates :page, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def search
    return [] if invalid?

    search_from_unsplash
  end

  private

  def search_from_unsplash
    Unsplash::Photo
      .search(q, page)
      .map { |result| parse_single_result result }
  end

  def parse_single_result(result)
    {
      image_url: result.urls.regular,
      thumbnail_url: result.urls.thumb
    }
  end
end

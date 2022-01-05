# frozen_string_literal: true

class Image < ApplicationRecord
  has_many :image_tags, inverse_of: :image, dependent: :delete_all
  has_many :tags, through: :image_tags, inverse_of: :images

  validates :url, presence: true, url: true, uniqueness: { case_sensitive: true }

  def apply_tags_by_name(tag_names)
    self.tags = tag_names.map { |tag_name| Tag.find_or_initialize_by(name: tag_name) }
  end

  class << self
    def register_with_tag_names(image_url:, tag_names: [])
      image = find_or_initialize_by(url: image_url)
      image.apply_tags_by_name tag_names
      image.tap(&:save!)
    end
  end
end

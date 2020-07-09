# frozen_string_literal: true

class Image < ApplicationRecord
  has_many :image_tags, inverse_of: :image, dependent: :delete_all
  has_many :tags, through: :image_tags, inverse_of: :images

  validates :url, presence: true, url: true, uniqueness: { case_sensitive: true }

  def apply_tags_by_name(tag_names)
    self.tag_ids = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name).id }
  end
end

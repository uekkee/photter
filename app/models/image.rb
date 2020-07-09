# frozen_string_literal: true

class Image < ApplicationRecord
  has_many :image_tags, inverse_of: :image, dependent: :delete_all
  has_many :tags, through: :image_tags, inverse_of: :images

  validates :url, presence: true, uniqueness: true
end

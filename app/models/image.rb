class Image < ApplicationRecord
  has_many :image_tags, inverse_of: :image
  has_many :tags, through: :image_tags
end

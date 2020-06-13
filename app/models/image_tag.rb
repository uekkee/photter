# frozen_string_literal: true

class ImageTag < ApplicationRecord
  belongs_to :image, inverse_of: :image_tags
  belongs_to :tag
end

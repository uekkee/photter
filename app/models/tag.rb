# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :image_tags, inverse_of: :tag, dependent: :delete_all
  has_many :images, through: :image_tags, inverse_of: :tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

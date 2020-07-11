# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :image_tags, inverse_of: :tag, dependent: :delete_all
  has_many :images, through: :image_tags, inverse_of: :tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :name_like, lambda { |keywords|
    queries = []
    keywords.count.times { queries << 'tags.name LIKE ?' }
    query = queries.join(' OR ')
    params = keywords.map { |keyword| "%#{sanitize_sql_like(keyword)}%" }
    where(query, *params)
  }
end

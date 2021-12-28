# frozen_string_literal: true

class RegisterImageWithTagsJob < ApplicationJob
  retry_on ActiveRecord::RecordNotUnique

  def perform(image_url:, tag_names:)
    Image.transaction do
      Image.register_with_tag_names image_url:, tag_names:
    end
  end
end

# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || valid_url?(value)

    record.errors.add attribute, 'is not URL-format'
  end

  private

  def valid_url?(value)
    value =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end

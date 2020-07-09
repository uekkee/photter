class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless value =~ /\A#{URI::regexp(%w(http https))}\z/
      record.errors.add attribute, 'is not URL-format'
    end
  end
end

# frozen_string_literal: true

module Shoulda
  module Matchers
    module ActiveModel
      def validate_url_of(attr)
        ValidateUrlOfMatcher.new(attr)
      end

      class ValidateUrlOfMatcher < ValidationMatcher
        def matches?(subject)
          super(subject)
          allows_value_of 'http://localhost.localdomain'
          disallows_value_of 'zzzhttp://localhost.localdomain', 'is not URL-format'
        end

        def simple_description
          "validate that :#{@attribute} is URL-format"
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'simplecov'
require 'simplecov-lcov'

puts 'Merging coverage results from parallel CircleCI tests containers into a single LCOV report...'

merged_result = SimpleCov::ResultMerger.merge_results *Dir['./cov/.resultset-*.json']

SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov::Formatter::LcovFormatter.config.single_report_path = './cov/all.lcov'
SimpleCov::Formatter::LcovFormatter.new.format(merged_result)

puts("Done! LCOV saved to #{SimpleCov::Formatter::LcovFormatter.config.single_report_path}")

# require 'simplecov'
# SimpleCov.start
# require 'rspec'
# require 'yaml'
# # require 'simplecov'

# # Dir[File.join('..', 'core', '**/*.rb')].each { |file| require file }

# # require './core/validation_module'
require 'simplecov'
require 'pry'
require 'yaml'
SimpleCov.start

require './dependency'
# # SimpleCov.start do
# #   add_filter '/spec/'
# #   minimum_coverage 95
# # end
#
# require "./spec_validation_module"
# require "./spec_game"
# require "./spec_validation_module"
# # Dir[File.join('..', 'core', '**/*.rb')].each { |file| require file }
# # Dir[File.join(File.dirname(__FILE__), '..', 'core', '**/*.rb')].each { |file| require file }
#
#
# RSpec.configure do |config|
#   config.expect_with :rspec do |expectations|
#     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
#   end
#   config.mock_with :rspec do |mocks|
#     mocks.verify_partial_doubles = true
#   end
#   config.shared_context_metadata_behavior = :apply_to_host_groups
# end
##################################
#
# SimpleCov.start do
#   add_filter(%r{\/spec\/})
# end
#
# require_relative '../dependency'

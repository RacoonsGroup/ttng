require 'simplecov'
require 'webmock/rspec'

SimpleCov.command_name 'RSpec'

SimpleCov.start 'rails' do
  add_group 'Services', 'app/services'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

require 'database_cleaner'
Dir[Rails.root.join('spec/support/mocks/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/webmocks/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :mocha
  config.render_views

  config.order = :random

end

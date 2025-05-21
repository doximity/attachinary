# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require "dotenv"
Dotenv.load(".env") if File.exist?(".env")

require File.expand_path('../spec/dummy/config/environment.rb', __dir__)
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '../../../spec/dummy'
require 'rspec/rails'

SPEC_ROOT = File.dirname(__FILE__)

require 'valid_attribute'
require 'capybara/rspec'

require 'factory_bot'
require "#{SPEC_ROOT}/factories"

require 'database_cleaner'

Capybara.javascript_driver = :selenium

require "#{SPEC_ROOT}/support/request_helpers"

RSpec.configure do |config|
  config.color = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.include FactoryBot::Syntax::Methods
  config.include RequestHelpers, type: :feature

  config.before(:each, type: :feature) do
    # include Rails.application.url_helpers
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do |example|
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    print "\n\n Cleaning up uploaded files"

    begin
      Cloudinary::Api.delete_resources_by_tag('test_env')
      print " (done)"
    rescue Cloudinary::Api::RateLimited => e
      print " (#{e.message})"
    end

    print "\n\n"
  end
end

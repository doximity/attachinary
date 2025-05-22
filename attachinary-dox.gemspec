$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "attachinary/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attachinary-dox"
  s.version     = Attachinary::VERSION
  s.authors     = ["Milovan Zogovic", "Doximity Team"]
  s.email       = ["engineering@doximity.com"]
  s.homepage    = ""
  s.summary     = "attachinary-#{s.version}"
  s.description = "Attachments handler for Rails that uses Cloudinary for storage. Forked from attachinary."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 7.0'
  s.add_dependency 'coffee-script'
  s.add_dependency 'cloudinary', '>= 1.1', '< 3.0'
  s.add_dependency 'mime-types'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'valid_attribute'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'mini_racer'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'sprockets-rails'
  s.add_development_dependency 'rspec_junit_formatter'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  s.add_development_dependency 'guard-rspec'
end

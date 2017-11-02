source 'http://rubygems.org'

# Declare your gem's dependencies in attachinary.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# used by the dummy application
gem 'jquery-rails'
gem 'simple_form'

# Assets gems used in dummy application
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.3.5'

source 'https://rails-assets.org' do
  gem 'rails-assets-blueimp-file-upload', '7.2.1'
end

# Stick with a working configuration
gem 'mongoid', '~> 5.0'

group :development, :test do
  gem 'pry'
  gem 'selenium-webdriver'
  gem 'vcr'
  gem 'webmock'
  gem 'travis'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

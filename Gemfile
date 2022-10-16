source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'pg'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'kaminari'
gem 'groupdate'
gem 'devise'

group :development, :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rubocop', '~> 0.87'
  gem 'simplecov', '0.16.1'
  gem 'simplecov-cobertura'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  gem 'debase'
  gem 'ruby-debug-ide'
  gem 'ruby-prof'
  gem 'benchmark'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'gruf-rspec'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 3.8.1'
  gem 'rubocop-rails_config'
  gem 'rubocop-rspec'
  gem 'database_cleaner-active_record'
  gem 'timecop'
  gem 'webmock'
  gem 'shoulda-matchers'
end

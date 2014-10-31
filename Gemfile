source 'https://rubygems.org'
ruby "2.1.3"

gem "rails", "4.1.5"
gem "jquery-rails"
gem "quiet_assets", "~> 1.0.1"
gem "bootstrap-sass", "~> 3.1.1.0"
gem "draper"
gem "webhook"
gem "g5_authenticatable"
gem "sass-rails", "~> 4.0.1"
gem "coffee-rails", "~> 4.0.1"
gem "uglifier", ">= 2.4.0"
gem "heroku_resque_autoscaler"
gem "rack-cors", require: "rack/cors"
gem 'active_model_serializers'
gem "paperclip", "~> 4.2"
gem 'aws-sdk', '~> 1.5.7'
gem "geocoder"

group :production do
  gem "unicorn"
  gem "pg"
  gem "rails_12factor"
  gem "newrelic_rpm"
  gem "honeybadger"
  gem "lograge"
end

group :development, :test do
  gem "dotenv-rails", "~> 0.10.0"
  gem "sqlite3"
  gem "simplecov", "~> 0.7.1", require: false
  gem 'rspec-rails', '> 3'
  gem 'rspec-its'
  # gem "guard-rspec"
  gem "guard-spork"
  gem "rb-fsevent", "~> 0.9.2"
  gem "fabrication", "~> 2.9.8"
  gem "faker", "~> 1.2.0"
  # ruby request specs
  gem "capybara", "~> 2.2.0"
  gem "launchy"
  gem "selenium-webdriver"
  gem "database_cleaner", "~> 1.2.0"
  gem "microformats2"
  gem "foreman"
  gem "factory_girl_rails"
  gem "shoulda-matchers"
  gem "better_errors"
  gem "binding_of_caller"
end

gem "codeclimate-test-reporter", group: :test, require: nil

source 'https://rubygems.org'
ruby "1.9.3"

gem "rails", "3.2.12"
gem "jquery-rails"

gem "quiet_assets", "~> 1.0.1"
gem "bootstrap-sass", "~> 3.0.2.1"
gem "draper"

gem "webhook", git: "git://github.com/G5/webhook.git", branch: "configuration"

group :assets do
  gem "sass-rails", "~> 3.2.5"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :production do
  gem "thin", "~> 1.5.0"
  gem "pg"
  gem "newrelic_rpm"
end

group :development, :test do
  gem "dotenv-rails", "~> 0.9.0"
  gem "rails-default-database", "~> 1.0.6"
  gem "sqlite3"
  gem "simplecov", "~> 0.7.1", require: false
  gem "rspec-rails", "~> 2.11.4"
  gem "guard-rspec", "~> 2.1.0"
  gem "guard-spork"
  gem "rb-fsevent", "~> 0.9.2"
  gem "debugger"
  gem "fabrication", "~> 2.5.0"
  gem "faker", "~> 1.1.2"
  # ruby request specs
  gem "capybara", "~> 2.1.0"
  gem "launchy"
  gem "selenium-webdriver", "~> 2.35.1"
  gem "database_cleaner", "~> 0.9.1"
end

gem "codeclimate-test-reporter", group: :test, require: nil

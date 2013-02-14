source :rubygems

gem "rails", "3.2.12"
gem "pg"
gem "jquery-rails"

gem "quiet_assets", "~> 1.0.1"
gem "bootstrap-sass", "~> 2.1.0.1"
gem "draper"

gem "webhook", git: "git://github.com/G5/webhook.git", branch: "configuration"

group :assets do
  gem "sass-rails", "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :production do
  gem "thin", "~> 1.5.0"
end

group :test do
  gem 'capybara'
end

group :development, :test do
  gem "rails-default-database", "~> 1.0.6"
  gem "simplecov", "~> 0.7.1", require: false
  gem "rspec-rails", "~> 2.11.4"
  gem "guard-rspec", "~> 2.1.0"
  gem "guard-spork"
  gem "rb-fsevent", "~> 0.9.2"
  gem "debugger"
  gem "fabrication", "~> 2.5.0"
  gem "faker", "~> 1.1.2"
end

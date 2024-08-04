# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.0'

gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[windows jruby]
gem 'bootsnap', require: false
gem 'httparty'
gem 'devise'

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webmock'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

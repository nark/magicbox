source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
	gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rubyserial'
gem 'apipie-rails'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'bootstrap', '~> 4.5.3'
gem 'bootstrap4-datetime-picker-rails'
gem 'bootstrap-select-rails'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap4'
#gem 'font-awesome-rails'
gem 'font-awesome-sass', '~> 5.11.2'
gem 'highcharts-rails'
gem 'chartkick'
gem 'groupdate'
gem 'nested_form'
gem 'whenever', require: false
gem 'sidekiq'
gem 'pg'
gem 'devise'
gem 'devise-i18n'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'simple_token_authentication', '~> 1.0'
gem 'breadcrumbs_on_rails'
gem 'hardware_information'
gem 'os'
gem 'open-weather'
gem 'openweather2'
gem 'barby'
gem 'rqrcode'
gem 'rmagick'
gem 'mini_magick'
gem 'simple_calendar', "~> 2.0"
gem 'dotenv-rails'
gem 'foreman'
gem 'onesignal-ruby'
gem 'dotiw'
gem 'active_model_serializers'
gem 'seed_dump'

install_if -> { RUBY_PLATFORM =~ /linux/ } do
  gem 'dht11'
  gem 'charlcd'
end

gem "rails-settings-cached", "~> 2.3"

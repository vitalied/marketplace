source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'figaro'
gem 'config', '~> 1.0.0.beta3'

gem 'devise'
gem 'cancancan'

gem 'kaminari'

gem 'sidekiq'
gem 'sinatra', require: nil

gem 'client_side_validations', github: 'DavyJonesLocker/client_side_validations'

gem 'paperclip'

gem 'bootstrap-sass'

gem 'best_in_place'

gem 'select2-rails', github: 'vitalied/select2-rails', branch: 'upgrade-version-4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'quiet_assets'

  gem 'rspec-rails'
end

group :development do
  gem 'thin'

  # deploy
  gem 'mina'
  gem 'mina-sidekiq', require: false
  #gem 'mina-unicorn', require: false

  gem 'letter_opener'
end

# Use Unicorn as the app server
#gem 'unicorn', group: :production

source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2', group: :production
gem 'aws-sdk'


gem 'twitter-bootstrap-rails'
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # asset transpilers
  gem 'sass-rails',   '~> 3.2.3'
  gem 'less-rails'
  gem 'haml-rails', '>= 0.3.4'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
	gem 'capistrano'
	gem 'rvm-capistrano'
  gem 'thin'  # faster web server
  gem 'wirb'  # autocomplete and coloring for rails c
end

gem 'faker' # library for generating fake data (used in the seed)

gem 'jquery-rails'
gem 'bootstrap-datepicker-rails' # javascript datepicker

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

gem 'passenger', :git => 'git@github.com:FooBarWidget/passenger.git'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# To use debugger
# gem 'debugger'

# For programmatically adding to the crontab
gem 'cronedit'
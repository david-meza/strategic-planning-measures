source 'https://rubygems.org'

ruby '2.2.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use devise for user authentication
gem 'devise', '~> 3.5.6'
gem 'will_paginate', '~> 3.0.7'
gem 'bootstrap-will_paginate', '~> 0.0.10'

gem 'rails-jquery-autocomplete'



# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem "letter_opener"

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'faker', '1.4.3'

  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'

end

group :test do
  gem 'guard-rspec', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'
  
  gem 'capybara'
  # gem 'launchy'
  # gem 'vcr'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end


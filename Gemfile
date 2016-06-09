source 'https://rubygems.org'

ruby '2.3.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.2'
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
gem 'will_paginate', '~> 3.1.0'
gem 'bootstrap-will_paginate', '~> 0.0.10'

gem 'wysiwyg-rails'


# Upload images to Amazon S3
gem 'aws-sdk', '>= 2.0.0'

# Manage file attachments with Paperclip
gem 'paperclip', '~> 5.0.0.beta2'

# Use figaro to manage environmental variables
gem 'figaro', '~> 1.1'

gem 'react-rails'

gem 'select2-rails'

gem 'sanitize'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary-edge', '~> 0.12.3.0'


# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'rails-erd'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'


  gem 'better_errors'
  gem 'binding_of_caller'


  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'

  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'

end

group :development, :test do
  gem 'faker', '1.4.3'

  gem 'letter_opener'
end

group :test do
  gem 'guard-rspec', require: false
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.0'

  gem 'shoulda-matchers', '~> 3.1'
  
  gem 'capybara'
  # gem 'launchy'
  # gem 'vcr'
  gem 'rake'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
end


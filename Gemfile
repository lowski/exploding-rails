source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'pg'
gem 'puma', '~> 5.0'

gem 'dry-monads'
gem 'dry-validation'
gem 'rom-rails'
gem 'rom-sql'

gem 'sass-rails', '>= 6'

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'rom-factory'
end

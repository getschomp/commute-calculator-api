source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'

# Database
# Wrapper for graph database neo4j
gem 'neo4j'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'

# Report test coverage
gem 'coveralls', require: false
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# encode and decode HMACSHA256 tokens
gem 'jwt'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'vcr'
  gem 'rspec-rails', '~> 3.5'
  gem 'pry-rails'
  gem 'rb-readline', '~> 0.5.3'
end

group :test do
  gem 'database_cleaner'
end

# Suggestions
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

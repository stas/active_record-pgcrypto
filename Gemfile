source 'https://rubygems.org'

gemspec

pg_version = '< 1' if ENV['RAILS_VERSION'].to_s.split.last.to_i == 4

group :development, :test do
  gem 'pg', pg_version
  gem 'rake'
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'yardstick'
end

group :test do
  gem 'ffaker'
  gem 'rspec'
  gem 'simplecov'
end

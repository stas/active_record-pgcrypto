lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/pgcrypto/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_record-pgcrypto'
  spec.version       = ActiveRecord::PGCrypto::VERSION
  spec.authors       = ['Stas SUȘCOV']
  spec.email         = ['stas@nerd.ro']

  spec.summary       = 'PGCrypto for ActiveRecord'
  spec.description   = 'PostgreSQL PGCrypto support for ActiveRecord models.'
  spec.homepage      = 'https://github.com/stas/active_record-pgcrypto'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('{lib,spec}/**/*', File::FNM_DOTMATCH)
  spec.files        += %w[LICENSE.txt README.md]
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', (ENV['RAILS_VERSION'] || '>= 3.2')

  pg_version = '< 1' if ENV['RAILS_VERSION'].to_s.split.last.to_i == 4

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'pg', pg_version
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yardstick'
end

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

  # Specify which files should be added to the gem when it is released.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', ENV['RAILS_VERSION']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yardstick'
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yaml'
require 'yardstick/rake/verify'

desc('Documentation stats and measurements')
task('qa:docs') do
  yaml = YAML.load_file('.yardstick.yml')
  config = Yardstick::Config.coerce(yaml)
  measure = Yardstick.measure(config)
  measure.puts
  coverage = Yardstick.round_percentage(measure.coverage * 100)
  exit(1) if coverage < config.threshold
end

RuboCop::RakeTask.new('qa:code')

desc('Run QA tasks')
task(qa: ['qa:docs', 'qa:code'])

RSpec::Core::RakeTask.new(spec: :qa)
task(default: :spec)

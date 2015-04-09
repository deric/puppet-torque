require 'bundler'
Bundler.require(:rake)
require 'rake/clean'

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'rspec-system/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
# blacksmith does not support ruby 1.8.7 anymore
require 'puppet_blacksmith/rake_tasks' if ENV['RAKE_ENV'] != 'ci' && RUBY_VERSION.split('.')[0,3].join.to_i > 187

desc "Lint metadata.json file"
task :meta do
  sh "metadata-json-lint metadata.json"
end

Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.disable_checks = [
    '80chars',
    'class_parameter_defaults',
    'class_inherits_from_params_class',
    'autoloader_layout'
  ]
  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
  config.fail_on_warnings = true
  #config.relative = true

  exclude_paths = [
    "pkg/**/*",
    "vendor/**/*",
    "spec/**/*",
  ]

  config.ignore_paths = exclude_paths
end

task :librarian_spec_prep do
  sh 'librarian-puppet install --path=spec/fixtures/modules/'
end
task :spec_prep => :librarian_spec_prep
task :default => [:spec, :lint]

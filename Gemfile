source 'https://rubygems.org'

group :rake do
  gem 'puppet',  '>= 2.7.0'
  gem 'puppet-lint', '>=0.3.2'
  gem 'puppetlabs_spec_helper', '>=0.2.0'
  gem 'rake',         '>=0.9.2.2'
  gem 'librarian-puppet', '>=0.9.10'
  gem 'rspec-system-puppet',     :require => false
  gem 'serverspec',              :require => false
  gem 'rspec-system-serverspec', :require => false
  gem 'hiera-puppet-helper', :git => 'https://github.com/mmz-srf/hiera-puppet-helper.git'
  gem 'rspec-puppet', '>= 2.0',  :require => false
  gem 'highline', '< 1.7.0' #to maintain ruby 1.8.7 compatibility
end

group :development do
  gem 'puppet-blacksmith',  '~> 3.0'
  gem 'metadata-json-lint',      :require => false
end

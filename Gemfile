source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :test do
  gem 'puppetlabs_spec_helper',               :require => 'false'
  gem 'rspec-puppet', '~> 2.2.0',             :require => 'false'
  gem 'rspec-puppet-facts',                   :require => 'false'
  gem 'metadata-json-lint',                   :require => 'false'
  gem 'puppet-lint-param-docs',               :require => 'false'
  gem 'puppet-lint-absolute_classname-check', :require => 'false'
  gem 'puppet-lint-absolute_template_path',   :require => 'false'
  gem 'puppet-lint-trailing_newline-check',   :require => 'false'
  gem 'puppet-lint-unquoted_string-check',    :require => 'false'
  gem 'puppet-lint-leading_zero-check',       :require => 'false'
  gem 'puppet-lint-variable_contains_upcase', :require => 'false'
  gem 'puppet-lint-numericvariable',          :require => 'false'
  gem 'json',                                 :require => 'false'
  gem 'puppet-openstack_spec_helper',
      :git => 'https://git.openstack.org/openstack/puppet-openstack_spec_helper',
      :require => false
end

group :local_only do
  gem "travis"
  gem "travis-lint"
  gem "beaker"
  gem "beaker-rspec"
  gem "vagrant-wrapper"
  gem "puppet-blacksmith"
  gem "guard-rake"
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

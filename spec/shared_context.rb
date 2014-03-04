require 'hiera-puppet-helper'

shared_context 'hieradata' do
  let :hiera_config do
    { :backends => ['yaml'],
      :hierarchy => [
        '%{fqdn}/%{calling_module}',
        '%{calling_module}'],
     :yaml => {
        :datadir => File.expand_path(File.join(__FILE__, '..','fixtures', 'hiera', 'test.yml'))
      },
    }
  end
end
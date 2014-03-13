require 'spec_helper'

describe 'torque::client' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
  }}

  let(:params){{
    :server_name => 'foo.bar'
  }}

  it { should contain_class('torque::client') }
  it { should contain_class('torque::mom') }

  it { should contain_package('torque-mom').with(
        :ensure => 'installed'
  )}

  it { should contain_package('torque-client').with(
        :ensure => 'installed'
  )}

  it { should contain_service('pbs_mom').with(
        :ensure => 'running',
        :enable => true
  )}
end
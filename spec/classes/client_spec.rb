require 'spec_helper'

describe 'torque::client' do
  include_context 'hieradata'

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
    :hostname        => 'foo.bar',
  }}

  let(:torque_home) { '/var/spool/torque' }

  let(:params) {{
    :torque_server => 'server.example.com',
    :torque_home   => torque_home
  }}

  it { should contain_class('torque::client') }
  it { should contain_class('torque::mom') }

  it { should contain_package('torque-mom').with(
        :ensure => 'installed'
  )}

  it { should contain_package('torque-client').with(
        :ensure => 'installed'
  )}

  # on Debian/Ubuntu it's torque-mom, some other distributions
  # maybe pbs_mom
  it { should contain_service('torque-mom').with(
        :ensure => 'running',
        :enable => true
  )}

  it {
    should contain_file(
      "#{torque_home}/server_name"
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    }).with_content(/foo.bar/)
  }

  it {
    should contain_file(
      '/var/spool/torque/mom_priv/config'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    }).with_content(/pbsserver server.example.com/)
  }

end
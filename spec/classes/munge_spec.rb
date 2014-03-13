require 'spec_helper'

describe 'torque::munge' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
  }}

  it { should contain_class('torque::munge') }
  it { should contain_package('munge').with(
        :ensure => 'installed'
  )}

  it { should contain_service('munge').with(
        :ensure => 'running',
        :enable => true
  )}

  it {
    should contain_file(
      '/etc/munge/munge.key'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'munge',
    'group'   => 'munge',
    'mode'    => '0400'
    })
  }

end
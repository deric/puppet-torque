require 'spec_helper'

describe 'torque::maui' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
  }}

  it { should contain_class('torque::maui') }
  it { should contain_package('maui').with(
        :ensure => 'installed'
  )}

  it { should contain_service('maui').with(
        :ensure => 'running',
        :enable => true
  )}

  it {
    should contain_file(
      '/var/spool/maui/maui.cfg'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644'
    }).with_content(
      /# maui.cfg 3.3.1/
  )}

end
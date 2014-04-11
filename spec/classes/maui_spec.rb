require 'spec_helper'

describe 'torque::maui' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :fqdn            => 'maui.example.com'
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
      '/usr/local/maui/maui.cfg'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644'
    }).with_content(
      /SERVERHOST maui.example.com/
  )}

  context 'allow changing maui directory' do
    let(:params){{
      :dir    => '/var/spool/maui',
      :server => 'server.example.com'
    }}

    it {
      should contain_file(
        '/var/spool/maui/maui.cfg'
      ).with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644'
      }).with_content(
        /SERVERHOST server.example.com/
    )}
  end

end
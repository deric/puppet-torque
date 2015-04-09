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
        :ensure => 'present'
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

  it {
    should contain_file(
      '/usr/local/maui'
    ).with({
    'ensure'  => 'directory',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644'
    })
  }

  context 'allow changing maui directory' do
    let(:confdir) { '/var/spool/maui' }
    let(:params){{
      :dir    => confdir,
      :server => 'server.example.com'
    }}

    it {
      should contain_file(
        "#{confdir}/maui.cfg"
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
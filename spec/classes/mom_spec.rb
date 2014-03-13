require 'spec_helper'

describe 'torque::mom' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
    :hostname        => 'foo.bar',
  }}

  it { should contain_class('torque::mom') }
  it { should contain_package('torque-mom') }

  let(:params) {{
    :torque_server => 'my.server.com'
  }}

  it {
    should contain_file(
      '/etc/torque/server_name'
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
    }).with_content(/pbsserver my.server.com/)
  }

  context 'changing torque home directory' do
    let(:params){{
      :torque_server => 'torque.server.com',
      :torque_home   => '/usr/spool/PBS'
    }}

    it {
      should contain_file(
        '/usr/spool/PBS/mom_priv/config'
      ).with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      }).with_content(/pbsserver torque.server.com/)
    }
  end
end
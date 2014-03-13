require 'spec_helper'

describe 'torque::mom' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
  }}

  let(:params){{
    :server_name => 'foo.bar',
  }}

  it { should contain_class('torque::mom') }
  it { should contain_package('torque-mom') }
  it { should contain_file('/etc/torque/mom/config') }

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
end
require 'spec_helper'

describe 'torque::mom' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
  }}

  it { should contain_class('torque::mom') }
  it { should contain_package('torque-mom') }
  it { should contain_file('/etc/torque/mom/config') }
end
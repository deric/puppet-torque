require 'spec_helper'

describe 'torque::client' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :processorcount  => 2,
  }}

  it { should contain_package('torque-mom') }
  it { should contain_package('torque-client') }

  it { should contain_service('pbs_mom') }
end
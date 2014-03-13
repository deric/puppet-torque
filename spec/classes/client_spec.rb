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

  it { should contain_package('torque-mom') }
  it { should contain_package('torque-client') }

  it { should contain_service('pbs_mom') }
end
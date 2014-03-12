require 'spec_helper'

describe 'torque::client' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid => 'Debian',
  }}

  it { should contain_package('torque-mom') }
  it { should contain_package('torque-client') }
end
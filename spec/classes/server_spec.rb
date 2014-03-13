require 'spec_helper'

describe 'torque::server' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid => 'Debian',
  }}

  include_context 'hieradata'

  it { should compile.with_all_deps }

  it { should contain_package('torque-server') }
  it { should contain_service('torque-server') }
end
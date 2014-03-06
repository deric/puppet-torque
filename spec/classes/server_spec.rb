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
  it { should contain_package('torque-client') }

  it { should contain_service('pbs_server') }


  it { should contain_apt__source('torque').with(
    'location'   => "http://debian.physik.hu-berlin.de/addons/wheezy",
  )}
end
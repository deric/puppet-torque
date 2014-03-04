require 'spec_helper'

describe 'torque::server' do

  include_context 'hieradata'

  it { should compile.with_all_deps }

  it { should contain_package('torque-server') }
  it { should contain_package('torque-client') }

end
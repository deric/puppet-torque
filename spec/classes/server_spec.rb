require 'spec_helper'

describe 'torque::server' do

  it { should contain_package('torque-server') }

  it { should contain_package('torque-client') }
end
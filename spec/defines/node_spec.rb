
require 'spec_helper'

describe 'torque::node' do
  let :title do
    'rspec-test'
  end

  let :facts do
    {
      :osfamily        => 'Debian',
      :operatingsystem => 'debian',
      :hostname        => 'foo.bar'
    }
  end

  it { should contain_concat__fragment(
    'torque_nodes_foo.bar'
    ).with_content(/foo.bar/) }

end
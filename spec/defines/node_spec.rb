
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

  it { should contain_file(
    '/var/spool/torque/server_priv/nodes'
    ).with({
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    })
  }
  it { should contain_concat__fragment('torque_nodes').with_content(/foo.bar/) }

end
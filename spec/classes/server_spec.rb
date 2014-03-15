require 'spec_helper'

describe 'torque::server' do

  let(:facts) {{
    :operatingsystem => 'Debian',
    :osfamily        => 'Debian',
    :lsbdistcodename => 'wheezy',
    :lsbdistid       => 'Debian',
    :hostname        => 'foo.bar',
    :concat_basedir  => '/var/lib/puppet/concat',
  }}

  include_context 'hieradata'

  it { should compile.with_all_deps }
  it { should contain_class('torque::server') }
  it { should contain_class('torque::server::config') }
  it { should contain_class('torque::maui') }
  it { should_not contain_class('torque::munge') }

  it { should contain_package('torque-server') }
  it { should contain_service('torque-server').with(
        :ensure => 'running',
        :enable => true
  )}

  it {
    should contain_file(
      '/etc/torque/server_name'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0644',
    }).with_content(/foo.bar/)
  }

  it {
    should contain_file(
      '/var/spool/torque/qmgr_config'
    ).with({
    'ensure'  => 'present',
    'owner'   => 'root',
    'group'   => 'root',
    'mode'    => '0600',
    }).with_content(/# server commands/)
  }

  context 'setting default queue' do
    let(:params){{
        :qmgr_conf => [
          'default_queue = my_queue'
        ]
    }}

    it { should contain_file(
        '/var/spool/torque/qmgr_config'
      ).with_content(/default_queue = my_queue/) }

    # should merge with defaults config
    it { should contain_file(
        '/var/spool/torque/qmgr_config'
      ).with_content(/node_check_rate = 150/) }
  end

  # TODO config should be a Hash, so that
  # we can merge it
  context 'overriding defaults' do
    let(:params){{
        :qmgr_conf => [
          'node_check_rate = 300'
        ]
    }}

    # it just appends at the end of the array
    it { should contain_file(
        '/var/spool/torque/qmgr_config'
      ).with_content(/node_check_rate = 300/) }
  end
end
require 'spec_helper'

describe 'torque' do
  shared_examples 'a Linux OS' do
    it { should compile.with_all_deps }
    it { should contain_class('torque') }
  end

  let(:torque_home) { '/var/spool/torque' }

  context 'Debian OS' do
    it_behaves_like 'a Linux OS' do
      let :facts do
        {
          :operatingsystem => 'Debian',
          :osfamily => 'debian',
          :lsbdistcodename => 'wheezy',
          :lsbdistid => 'debian',
        }
      end


      it {
        should contain_file(
          "#{torque_home}"
        ).with({
        'ensure'  => 'directory',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        })
      }

      it { should contain_file(
        '/etc/torque/server_name'
        ).with({
          'ensure' => 'link'
      })}

      context 'enable apt repository' do
        let(:params) {{
          :manage_repo => true,
        }}

        it { should contain_apt__source('torque').with(
          'location' => 'http://debian.physik.hu-berlin.de/addons/wheezy'
        )}
      end

      context 'setting custom server_name' do
        let(:params) {{
          :server_name => 'server.example.com'
        }}

        it {
          should contain_file(
            "#{torque_home}/server_name"
          ).with_content(/server.example.com/)
        }
      end
    end
  end
end
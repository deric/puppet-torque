require 'spec_helper'

describe 'torque' do
  shared_examples 'a Linux OS' do
    it { should compile.with_all_deps }
    it { should contain_class('torque') }
  end

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

      context 'enable apt repository' do
        let(:params) {{
          :manage_repo => true,
        }}

        it { should contain_apt__source('torque').with(
          'location' => 'http://debian.physik.hu-berlin.de/addons/wheezy'
        )}
      end
    end
  end

end
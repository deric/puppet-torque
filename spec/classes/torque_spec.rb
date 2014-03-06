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
    end
  end
end
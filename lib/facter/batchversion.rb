# batchversion.rb
Facter.add(:batchversion) do
  confine :osfamily => 'RedHat'
  setcode do
  	Facter::Util::Resolution::exec('rpm -q --qf "%{VERSION}\n" torque')
  end
end

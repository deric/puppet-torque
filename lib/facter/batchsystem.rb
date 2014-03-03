# batchsystem.rb
Facter.add(:batchsystem) do
  confine :osfamily => 'RedHat'
  setcode do
  	Facter::Util::Resolution::exec('rpm -q --qf "%{NAME}\n" torque')
  end
end

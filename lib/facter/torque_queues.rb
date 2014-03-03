# torque_queues
Facter.add(:torque_queues) do
  confine :osfamily => 'RedHat'
  confine :batchsystem => 'torque'
  setcode do
    tq = Facter::Util::Resolution::exec("qstat -Q | awk 'NR>2 {print $1}'")
    tq.nil? ? nil : tq.tr("\n", ',')
  end
end

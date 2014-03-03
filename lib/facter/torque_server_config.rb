# torque_server_config
Facter.add(:torque_server_config) do
  confine :osfamily => 'RedHat'
  confine :batchsystem => 'torque'
  setcode do
    tsc = Facter::Util::Resolution::exec("qmgr -c 'print server' | sed -n 's/^set server //p'")
    tsc.nil? ? nil : tsc.tr("\n", ',')
  end
end

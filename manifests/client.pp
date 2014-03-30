class torque::client(
  $torque_server,
  $mom_ensure         = 'installed',
  $package_ensure     = 'installed',
  $mom_service_name   = 'torque-mom',
  $mom_service_enable = true,
  $mom_service_ensure = 'running',
  $enable_munge       = false,
  $torque_home        = '/var/spool/torque',
  $hostname           = $::hostname,
  $cpus               = $::processorcount,
  $gpus               = 0,
  ) inherits torque {

  $fhost = $::fqdn

  # command line interface to Torque server
  package { 'torque-client':
    ensure => $package_ensure,
  }

  class { 'torque::mom':
    torque_server      => $torque_server,
    mom_ensure         => $mom_ensure,
    mom_service_name   => $mom_service_name,
    mom_service_enable => $mom_service_enable,
    mom_service_ensure => $mom_service_ensure,
  }

  if($enable_munge) {
    class { 'torque::munge': }
  }

  @@concat::fragment{ "torque_client_${fhost}":
    target  => "${torque_home}/server_priv/nodes",
    content => template("${module_name}/client.erb"),
    tag     => 'torque'
  }
}

# Torque client -- mom
#   should be install on computing nodes
#
class torque::client(
  $torque_server,
  $mom_ensure         = 'installed',
  $package_ensure     = 'installed',
  $mom_service_name   = 'torque-mom',
  $mom_service_enable = true,
  $mom_service_ensure = 'running',
  $enable_munge       = false,
  $torque_home        = $torque::torque_home,
  $hostname           = $::hostname,
  $cpus               = $::processorcount,
  $gpus               = 0,
  $export_tag         = 'torque',
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

  file { "${torque_home}/server_priv":
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

}

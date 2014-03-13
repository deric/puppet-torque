class torque::client(
  $server_name,
  $mom_ensure         = 'installed',
  $ensure             = 'installed',
  $mom_service_enable = true,
  $mom_service_ensure = true,
  ) inherits torque {

  # command line interface to Torque server
  package { 'torque-client':
    ensure => $ensure,
  }

  class { 'torque::mom':
    torque_server =>  $server_name,
  }

  service { 'pbs_mom':
    ensure     => $mom_service_ensure,
    enable     => $mom_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['torque-mom'], Class['torque::mom']],
    subscribe  => File['/etc/torque/mom/config'],
  }

  class { 'torque::munge': }
}

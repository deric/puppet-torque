class torque::client(
  $server_name,
  $mom_ensure         = 'installed',
  $package_ensure     = 'installed',
  $mom_service_enable = true,
  $mom_service_ensure = 'running',
  ) inherits torque {

  # command line interface to Torque server
  package { 'torque-client':
    ensure => $package_ensure,
  }

  class { 'torque::mom':
    torque_server => $server_name,
    mom_ensure    => $mom_ensure
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

class torque::client(
  $server_name        = $torque::server_name,
  $mom_ensure         = 'installed',
  $package_ensure     = 'installed',
  $mom_service_name   = 'torque-mom',
  $mom_service_enable = true,
  $mom_service_ensure = 'running',
  $enable_munge       = false,
  ) inherits torque {

  # command line interface to Torque server
  package { 'torque-client':
    ensure => $package_ensure,
  }

  class { 'torque::mom':
    server_name   => $server_name,
    mom_ensure    => $mom_ensure
  }

  service { $mom_service_name:
    ensure     => $mom_service_ensure,
    enable     => $mom_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['torque-mom'], Class['torque::mom']],
    subscribe  => File['/etc/torque/mom/config'],
  }

  if($enable_munge) {
    class { 'torque::munge': }
  }
}

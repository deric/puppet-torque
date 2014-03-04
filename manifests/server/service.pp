class torque::server::service(
  $ensure = 'running',
  $enable = true,
) inherits torque {
  service { 'pbs_server':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['torque-server'],
    subscribe  => File['/etc/torque/server_name'],
  }
}

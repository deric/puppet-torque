class torque::server::service(
  $ensure = $torque::params::server_service_ensure,
  $enable = $torque::params::server_service_enable,
) inherits torque::params {
  service { 'pbs_server':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['torque-server'],
    subscribe  => File['/etc/torque/server_name'],
  }
}

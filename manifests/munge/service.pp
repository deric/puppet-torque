class torque::munge::service(
  $ensure = $torque::params::munge_service_ensure,
  $enable = $torque::params::munge_service_enabled,
) inherits torque::params {
  service { 'munge':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['munge'],
    subscribe  => File['/etc/munge/munge.key'],
  }
}

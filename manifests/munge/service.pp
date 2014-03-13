class torque::munge::service(
  $ensure = 'running',
  $enable = true,
) {
  service { 'munge':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['munge'],
    subscribe  => File['/etc/munge/munge.key'],
  }
}

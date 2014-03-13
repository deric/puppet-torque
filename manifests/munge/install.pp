class torque::munge::install(
  $ensure = 'present',
) {
  package { 'munge':
    ensure => $ensure,
  }
}

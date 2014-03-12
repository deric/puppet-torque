class torque::munge::install(
  $ensure = $torque::munge::install_ensure,
) {
  package { 'munge':
    ensure => $ensure,
  }
}

class torque::munge::install(
  $ensure = $torque::params::munge_install_ensure,
) {
  package { 'munge':
    ensure => $ensure,
  }
}

class torque::mom::install(
  $mom_ensure    = $torque::params::mom_install_ensure,
  $client_ensure = $torque::params::client_install_ensure
) inherits torque::params {
  package { 'torque-mom':
    ensure => $mom_ensure,
  }
  package { 'torque-client':
    ensure => $client_ensure,
  }
}

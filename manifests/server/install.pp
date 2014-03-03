class torque::server::install(
  $server_ensure = $torque::params::server_install_ensure,
  $client_ensure = $torque::params::client_install_ensure
) inherits torque::params {
  package { 'torque-server':
    ensure => $server_ensure,
  }
  package { 'torque-client':
    ensure => $client_ensure,
  }
}

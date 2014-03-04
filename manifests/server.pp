# Torque server installation
#
class torque::server(
  $server_ensure = 'present',
  $client_ensure = 'present',
) {
  package { 'torque-server':
    ensure => $server_ensure,
  }
  package { 'torque-client':
    ensure => $client_ensure,
  }

  class { 'torque::server::config': }
  class { 'torque::server::service': }
  #class { 'torque::munge': }
  class { 'torque::maui': }
}

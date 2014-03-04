#
# Torque server installation
#
class torque::server::install(
  $server_ensure = 'present',
  $client_ensure = 'present',
) {
  package { 'torque-server':
    ensure => $server_ensure,
  }
  package { 'torque-client':
    ensure => $client_ensure,
  }
}

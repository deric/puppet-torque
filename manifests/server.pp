# Torque server installation
#
class torque::server(
  $server_ensure  = 'present',
  $client_ensure  = 'present',
  $service_name   = 'torque-server',
  $service_ensure = 'running',
  $service_enable = true,
) inherits torque {

  package { 'torque-server':
    ensure => $server_ensure,
  }
  package { 'torque-client':
    ensure => $client_ensure,
  }

  class { 'torque::server::config': }

  service { $service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['torque-server'],
    subscribe  => File['/etc/torque/server_name'],
  }

  #class { 'torque::munge': }
  class { 'torque::maui': }
}

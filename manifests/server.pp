# Torque server installation
#
class torque::server(
  $server_name    = $::hostname,
  $server_ensure  = 'present',
  $client_ensure  = 'present',
  $service_name   = 'torque-server',
  $service_ensure = 'running',
  $service_enable = true,
) inherits torque {

  package { 'torque-server':
    ensure => $server_ensure,
  }

  file { '/etc/torque/server_name':
    ensure  => 'present',
    content => template("${module_name}/server_name.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['torque-server'],
  }

  class { 'torque::server::config':

  }

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

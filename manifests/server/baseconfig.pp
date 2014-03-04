class torque::server::baseconfig(
  $torque_server = $torque::server_name
) inherits torque {
  file { '/etc/torque/server_name':
    ensure  => 'present',
    content => template("${module_name}/server_name.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['torque-server'],
  }
}


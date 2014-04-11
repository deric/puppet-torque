#
#
define torque::node(
  $torque_home        = '/var/spool/torque',
  $hostname           = $::hostname,
){

  concat::fragment{ "torque_nodes_${hostname}":
    ensure  => present,
    target  => $nodes_config,
    content => template("${module_name}/client.erb"),
    order   => '001',
    tag     => 'torque'
  }

}
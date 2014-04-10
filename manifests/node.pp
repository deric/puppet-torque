#
#
define torque::node(
  $torque_home        = '/var/spool/torque',
  $hostname           = $::hostname,
){

  $nodes_config = "${torque_home}/server_priv/nodes"

  concat { $nodes_config:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment{ 'torque_nodes':
    ensure  => present,
    target  => $nodes_config,
    content => template("${module_name}/client.erb"),
    order   => '001',
  }

}
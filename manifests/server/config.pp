class torque::server::config (
  $qmgr_server,
  $qmgr_queue_defaults,
  $qmgr_queues,
  $qmgr_present,
  $torque_home = '/var/spool/torque',
  $export_tag = 'torque',
  $service_name = 'torque-server'
) {

  include concat::setup

  Concat::Fragment <<| tag == $export_tag |>>

  validate_array($qmgr_server)
  validate_array($qmgr_queue_defaults)
  validate_array($qmgr_present)
  validate_hash($qmgr_queues)

  $sconfig = torque_config_diff('server', $qmgr_server)
  $qconfig = torque_config_diff('queue', $qmgr_queues, $qmgr_queue_defaults)

  file { $torque_home:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

  file { "${torque_home}/qmgr_config":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('torque/qmgr_config.erb'),
    require => File[$torque_home],
  }

  exec { 'qmgr update':
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => "cat ${torque_home}/qmgr_config | qmgr",
    onlyif      => "grep -vq \"^[[:space:]]*\(#\|$\)\" ${torque_home}/qmgr_config",
    refreshonly => true,
    subscribe   => File["${torque_home}/qmgr_config"],
    logoutput   => true,
  }

  file { "${torque_home}/server_priv":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

  concat{ "${torque_home}/server_priv/nodes":
    owner   => root,
    group   => 0,
    mode    => '0644',
    require => File["${torque_home}/server_priv"],
    notify  => Service[$service_name]
  }


}
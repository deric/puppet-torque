class torque::server::config (
  $qmgr_server         = $torque::params::torque_qmgr_server,
  $qmgr_queue_defaults = $torque::params::torque_qmgr_qdefaults,
  $qmgr_queues         = $torque::params::torque_qmgr_queues,
) inherits torque::params {

  $sconfig = torque_config_diff('server', $qmgr_server)
  $qconfig = torque_config_diff('queue', $qmgr_queues, $qmgr_queue_defaults)

  file { '/var/lib/torque':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

  file { '/var/lib/torque/qmgr_config':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('torque/qmgr_config.erb'),
    require => File['/var/lib/torque'],
  }

  exec { 'qmgr update':
    path        => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin',
    command     => 'cat /var/lib/torque/qmgr_config | qmgr',
    onlyif      => 'grep -vq "^[[:space:]]*\(#\|$\)" /var/lib/torque/qmgr_config',
    refreshonly => true,
    subscribe   => File['/var/lib/torque/qmgr_config'],
    logoutput   => true,
  }
}
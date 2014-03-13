class torque::mom(
  $server_name       = $torque::server_name,
  $restricted        = [],
  $ideal_load_adj    = 0.2,
  $max_load_adj      = 1.2,
  $options           = {
                       logevent => 255,
                     },
  $usecp             = [],
  $mom_prologue_file = undef,
  $mom_epilogue_file = undef,
  $mom_service_name  = 'torque-mom',
  $mom_ensure        = 'installed',
  $mom_service_enable = true,
  $mom_service_ensure = 'running',
  # For TORQUE 2.1 and later, TORQUE_HOME is /var/spool/torque/
  $torque_home       = '/var/spool/torque'
) inherits torque {

  # job execution engine for Torque batch system
  package { 'torque-mom':
    ensure => $mom_ensure,
  }

  file { '/etc/torque/mom':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { "${torque_home}/mom_priv":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { "${torque_home}/mom_priv/config":
    ensure  => 'present',
    content => template('torque/pbs_config.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [File["${torque_home}/mom_priv"], Package['torque-mom']],
  }

  if ( $mom_prologue_file )  {
    file { "${torque_home}/mom_priv/prologue":
      ensure  => 'present',
      source  => $mom_prologue_file,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => [File["${torque_home}/mom_priv"], Package['torque-mom']],
    }
  }

  if ( $mom_epilogue_file )  {
    file { "${torque_home}/mom_priv/epilogue":
      ensure  => 'present',
      source  => $mom_epilogue_file,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => [File["${torque_home}/mom_priv"], Package['torque-mom']],
    }
  }

  service { $mom_service_name:
    ensure     => $mom_service_ensure,
    enable     => $mom_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['torque-mom']],
    subscribe  => File["${torque_home}/mom_priv/config"],
  }

}

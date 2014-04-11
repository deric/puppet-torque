class torque::maui(
  # maui options
  # Copy from file server
  # If this is not undef, the maui configuration will be COPIED from the server rather than
  # BUILT from a template
  $mauifile          = undef,
  # set up maui using puppet
  $install_ensure    = 'installed',
  $service_ensure    = 'running',
  $package           = 'maui',
  $service_enable    = true,
  $service_name      = 'maui',
  $server            = $::fqdn,
  $port              = 42559,
  $mode              = 'NORMAL',
  $rmcfg_type        = 'PBS',
  $rmcfg_options     = 'TIMEOUT=90',
  $adminhost         = $::fqdn,
  $admin1            = 'root',
  $admin3            = undef,
  $general_options   = {
    'NODESYNCTIME'     => '00:00:30',
    # Set PBS server polling interval. If you have short # queues
    # or/and jobs it is worth to set a short interval. (default 10 seconds)
    'RMPOLLINTERVAL'   => '00:00:30',
    # a max. 10 MByte log file in a logical location
    'LOGFILE'          => '/var/log/maui.log',
    'LOGFILEMAXSIZE'   => 10000000,
    'LOGLEVEL'         => 1,
    'LOGFILEROLEDEPTH' => 10,
    # Set the delay to 5 min before Maui tries to run a job again, in
    # case it failed to run the first time. The default value is 1 hour.
    'DEFERTIME'        => '00:05:00',
  },
  $options           = {},
  $groupcfg          = {},
  $usercfg           = {},
  $srcfg             = {},
  $dir               = '/usr/local/maui',
) {
  validate_bool($service_enable)
  validate_hash($options)
  validate_hash($groupcfg)
  validate_hash($usercfg)
  validate_hash($srcfg)

  package { $package:
    ensure => $install_ensure,
  }

  if ($mauifile  != undef) {
    file { "${dir}/maui.cfg":
      ensure  => 'present',
      source  => $mauifile,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$package],
    }
  } else {
    file { "${dir}/maui.cfg":
      ensure  => 'present',
      content => template("${module_name}/maui.cfg.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$package],
    }
  }

  service { $service_name:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package[$package], File["${dir}/maui.cfg"]],
    subscribe  => File["${dir}/maui.cfg"],
  }
}

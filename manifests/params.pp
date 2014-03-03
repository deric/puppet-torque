class torque::params {
  # munge options
  $munge_install_ensure   = hiera("torque::params::munge_install_ensure", 'installed')
  $munge_service_ensure   = hiera("torque::params::munge_service_ensure", 'running')
  $munge_service_enabled  = hiera("torque::params::munge_service_enabled", true)
  $munge_key_location     = hiera("torque::params::munge_key_location", undef)

  # mom options
  $mom_install_ensure     = hiera("torque::params::mom_install_ensure", 'installed')
  $client_install_ensure  = hiera("torque::params::client_install_ensure", 'installed')
  $mom_service_ensure     = hiera("torque::params::mom_service_ensure", 'running')
  $mom_service_enable     = hiera("torque::params::mom_service_enable", true)
  $torque_server          = hiera("torque::params::torque_server", undef )
  $mom_restricted         = hiera("torque::params::mom_restricted", [])
  $mom_ideal_load_adj     = hiera("torque::params::mom_ideal_load_adj", 0.2)
  $mom_max_load_adj       = hiera("torque::params::mom_max_load_adj", 1.2)
  #Directories to transfer the output using cp only
  $mom_use_cp             = hiera_array("torque::params::mom_use_cp", [])
  #Additional mom options specified in a hash
  $mom_options            = hiera("torque::params::mom_options", {
    logevent => 255,
  })
  $mom_prologue_file      = hiera("torque::params::mom_prologue_file", undef)
  $mom_epilogue_file      = hiera("torque::params::mom_epilogue_file", undef)


  # server options
  $server_install_ensure  = hiera("torque::params::server_install_ensure", 'installed')
  $server_service_ensure  = hiera("torque::params::server_service_ensure", 'running')
  $server_service_enable  = hiera("torque::params::server_service_enable", true)
  $torque_server_name     = hiera("torque::params::torque_server_name", $::fqdn)
  # the following options are protected from being unset if they don't appear in torque_qmgr_server
  $torque_qmgr_present    = hiera("torque::params::torque_qmgr_present", [
    'acl_hosts',
    'node_check_rate',
    'tcp_timeout',
    'next_job_number',
  ])
  # default torque server configuration that is set by qmgr ('set server ' is prepended by the module)
  $torque_qmgr_server     = hiera("torque::params::torque_qmgr_server", [
    # internal defaults, usually not needed
#    "acl_hosts = ${::fqdn}",
#    'node_check_rate = 150',
#    'tcp_timeout = 6',
#    'next_job_number = 0',
    #
    'scheduling = True',
    'acl_host_enable = False',
    "managers = root@${::fqdn}",
    "operators = root@${::fqdn}",
    'default_queue = dteam',
    'log_events = 511',
    'mail_from = adm',
    'mail_domain = never',
    'query_other_jobs = True',
    'scheduler_iteration = 600',
    'default_node = lcgpro',
    'node_pack = False',
    'kill_delay = 10',
    "authorized_users = *@${::fqdn}",
  ])
  # default set up for a single queue
  $torque_qmgr_qdefaults  = hiera("torque::params::torque_qmgr_qdefaults", [
    'queue_type = Execution',
    'resources_max.cput = 48:00:00',
    'resources_max.walltime = 72:00:00',
    'enabled = True',
    'started = True',
    'acl_group_enable = True',
  ])
  # default queue definitions
  # empty, because queues are not set up by default
  # this is a hash with the queue name as key and an array of configuration options as value
  # if no value is specified then the default options array ($torque_qmgr_qdefaults) is used
  $torque_qmgr_queues     = hiera("torque::params::torque_qmgr_queues", {})
  # maui options
  # Copy from file server
  # If this is not undef, the maui configuration will be COPIED from the server rather than 
  # BUILT from a template
  $mauifile               = hiera("torque::params::mauifile", undef)
 
  # set up maui using puppet
  $maui_install_ensure    = hiera("torque::params::maui_install_ensure", 'installed')
  $maui_service_ensure    = hiera("torque::params::maui_service_ensure", 'running')
  $maui_service_enable    = hiera("torque::params::maui_service_enable", true)
  $maui_server            = hiera("torque::params::maui_server", $::fqdn)
  $maui_port              = hiera("torque::params::maui_port", 40559)
  $maui_mode              = hiera("torque::params::maui_mode", 'NORMAL')
  $maui_rmcfgtype         = hiera("torque::params::maui_rmcfgtype", 'PBS')
  $maui_rmcfgopt          = hiera("torque::params::maui_rmcfgopt", 'TIMEOUT=90')
  $maui_adminhost         = hiera("torque::params::maui_adminhost", $::fqdn)
  $maui_admin1            = hiera("torque::params::maui_admin1",'root')
  $maui_admin3            = hiera("torque::params::maui_admin3",undef)
  $maui_generalopt        = hiera("torque::params::maui_generalopt", {
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
  })
  $maui_options           = hiera("torque::params::maui_options", {})
  $maui_groupcfg          = hiera("torque::params::maui_groupcfg", {})
  $maui_usercfg           = hiera("torque::params::maui_usercfg", {})
  $maui_srcfg             = hiera("torque::params::maui_srcfg", {})
}

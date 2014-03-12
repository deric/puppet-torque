class torque::params {

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
  $server_service_ensure  = hiera("torque::params::server_service_ensure", 'running')
  $server_service_enable  = hiera("torque::params::server_service_enable", true)

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
}

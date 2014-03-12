class torque::params {

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

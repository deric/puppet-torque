class torque::server::config (
  $torque_server       =  $torque::params::torque_server_name,
  $qmgr_server         =  $torque::params::torque_qmgr_server,
  $qmgr_queue_defaults =  $torque::params::torque_qmgr_qdefaults,
  $qmgr_queues         =  $torque::params::torque_qmgr_queues,
) inherits torque::params
{
    class {'torque::server::baseconfig':
       torque_server       => $torque_server
    }
    class {'torque::server::qmgrconfig':
       qmgr_server         => $qmgr_server ,
       qmgr_queue_defaults => $qmgr_queue_defaults,
       qmgr_queues         => $qmgr_queues
    }
}

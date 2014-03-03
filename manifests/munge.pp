class torque::munge {
  class { 'torque::munge::install': }
  class { 'torque::munge::service': }
  class { 'torque::munge::config': }
}

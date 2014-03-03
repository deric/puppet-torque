class torque::mom {
  class { 'torque::mom::install': }
  class { 'torque::mom::config': }
  class { 'torque::mom::service': }
  class { 'torque::munge': }
}

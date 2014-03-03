class torque::server {
  class { 'torque::server::install': }
  class { 'torque::server::config': }
  class { 'torque::server::service': }
  class { 'torque::munge': }
  class { 'torque::maui': }
}

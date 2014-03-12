class torque::munge(
  # munge options
  $install_ensure   = 'installed',
  $service_ensure   = 'running',
  $service_enabled  = true,
  $key_location     = undef,
  ) {
  class { 'torque::munge::install': }
  class { 'torque::munge::service': }
  class { 'torque::munge::config': }
}

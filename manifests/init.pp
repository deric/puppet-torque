# Class: torque
#
# This module manages torque
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Do not use this class directly (use either server or client)
#
class torque(
  $server_name    = $::hostname,
  $manage_repo    = false,
  $package_source = 'hu-berlin',
) {

  class {'torque::repo':
    manage_repo => $manage_repo,
  }

  file { '/etc/torque/server_name':
    ensure  => 'present',
    content => template("${module_name}/server_name.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}

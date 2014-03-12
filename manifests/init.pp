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
# Sample Usage:
#
class torque(
  $server_name    = $::fqdn,
  $manage_repo    = false,
  $package_source = 'hu-berlin',

) {

  class {'torque::repo':
    manage_repo => $manage_repo,
  }

}

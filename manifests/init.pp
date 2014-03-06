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
  $manage_repo    = true,
  $package_source = 'hu-berlin',
) {

  case $::osfamily {
    'Debian': {
      class { 'torque::repo::debian':
        package_source => $package_source,
        manage_repo    => $manage_repo,
      }
    }
    default: {
      fail("Module ${module_name} is not supported on ${::osfamily}, os: ${::operatingsystem}")
    }
  }

}

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
  $manage_repo    = false,
  $package_source = 'hu-berlin',
) {

  class {'torque::repo':
    manage_repo => $manage_repo,
  }

}

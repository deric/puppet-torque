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
class torque {
  $server_name = hiera('torque::server_name', $::fqdn)
}

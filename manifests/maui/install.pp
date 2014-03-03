class torque::maui::install(
  $ensure = $torque::params::maui_install_ensure,
) {
  package { 'maui-server':
    ensure => $ensure,
  }
}

class torque::maui::service(
  $ensure = $torque::params::maui_service_ensure,
  $enable = $torque::params::maui_service_enable,
) {
  service { 'maui':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['maui-server'],
    subscribe  => File['/var/spool/maui/maui.cfg'],
  }
}

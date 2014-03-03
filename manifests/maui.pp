class torque::maui {
  class { 'torque::maui::install': }
  class { 'torque::maui::config': }
  class { 'torque::maui::service': }
}

class torque::maui::config(
  $server          = $torque::params::maui_server,
  $port            = $torque::params::maui_port,
  $mode            = $torque::params::maui_mode,
  $rmcfg_type      = $torque::params::maui_rmcfgtype,
  $rmcfg_options   = $torque::params::maui_rmcfgopt,
  $adminhost       = $torque::params::maui_adminhost,
  $admin1          = $torque::params::maui_admin1,
  $admin3          = $torque::params::maui_admin3,
  $general_options = $torque::params::maui_generalopt,
  $options         = $torque::params::maui_options,
  $groupcfg        = $torque::params::maui_groupcfg,
  $usercfg         = $torque::params::maui_usercfg,
  $srcfg           = $torque::params::maui_srcfg,
  $mauifile        = $torque::params::mauifile
) inherits torque::params {
    if ($mauifile  == undef) {
      file { '/var/spool/maui/maui.cfg':
           ensure  => 'present',
           content => template('torque/maui.cfg.erb'),
      #    source  => $mauifile,
           owner   => 'root',
           group   => 'root',
           mode    => '0644',
           require => Package['maui-server'],
       }
   }
        
    else {
 
      file { '/var/spool/maui/maui.cfg':
           ensure  => 'present',
      #    content => template('torque/maui.cfg.erb'),
           source  => $mauifile,
           owner   => 'root',
           group   => 'root',
           mode    => '0644',
           require => Package['maui-server'],
       }

   }
}

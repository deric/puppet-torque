# munge installation
class torque::munge(
  $package_ensure   = 'installed',
  $service_ensure   = 'running',
  $service_enabled  = true,
  $key_location     = undef,
  ) {

  package { 'munge':
    ensure => $package_ensure,
  }

  file { '/etc/munge/munge.key':
    ensure  => 'present',
    source  => $key_location,
    owner   => 'munge',
    group   => 'munge',
    mode    => '0400',
    require => Package['munge'],
  }

  service { 'munge':
    ensure     => $service_ensure,
    enable     => $service_enabled,
    hasrestart => true,
    hasstatus  => true,
    require    => [File['/etc/munge/munge.key'], Package['munge']],
    subscribe  => File['/etc/munge/munge.key'],
  }
}

class torque::munge::config(
  $key_location = undef,
) {
  file { '/etc/munge/munge.key':
    ensure  => 'present',
    source  => $key_location,
    owner   => 'munge',
    group   => 'munge',
    mode    => '0400',
    require => Package['munge'],
  }
}

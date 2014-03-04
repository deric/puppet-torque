class torque::server {
  class { 'torque::server::install':
    server_ensure  => hiera('torque::server::ensure', 'installed'),
    client_ensure  => hiera('torque::client::ensure', 'installed'),
  }
  class { 'torque::server::config': }
  class { 'torque::server::service': }
  #class { 'torque::munge': }
  class { 'torque::maui': }
}

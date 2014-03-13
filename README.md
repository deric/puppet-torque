#puppet-torque
[![Build Status](https://travis-ci.org/deric/puppet-torque.png?branch=master)](https://travis-ci.org/deric/puppet-torque)

This is a Puppet module for managing Torque resource manager and Maui scheduler.

## Usage

server:
```puppet
class { 'torque::server': }
```
By default `server_name` is the `$::hostname` of the server node (we get it from Facter). You can choose to use other fact of some value, e.g.:

```puppet
class { 'torque':
  server_name => $::fqdn
}
```

  * One can run both the server and client on the same box (Within server class is not included client)

client (a computing node):

```puppet
class { 'torque::client': }
```


## Maui

In order to install Maui you have to have a binary package for your distribution.

 * [Debian/Ubuntu](https://github.com/deric/maui-deb-packaging)


## Hiera support

Hiera is supported out-of-the-box, you can set any class parameter from YAML config files.

```yaml
torque::server_name: '192.168.1.1'
```


## License

Apache License 2.0

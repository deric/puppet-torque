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

Default Torque home directory is `/var/spool/torque`, you can change it:

```puppet
class { 'torque':
  torque_home => '/etc/torque'
}
```


### Queues

Queues can be configured via `qmgr_queues` hash which you pass to `torque::server`.

```yaml
torque::server::qmgr_queues:
  short:
    - 'enabled = True'
    - 'started = True'
    - 'queue_type = Execution'
```


### Nodes

Nodes can be specified via Hiera config (also you can pass a config hash to `torque::server` class):

```yaml
torque::server::nodes:
  myserver1:
    cpus: 10
  gpu.example.com:
    cpus: 5
    gpus: 10
```

## Maui

In order to install Maui you have to have a binary package for your distribution.

 * [Debian/Ubuntu](https://github.com/deric/maui-deb-packaging)


## Hiera support

Hiera is supported out-of-the-box, you can set any class parameter from YAML config files.

```yaml
torque::server_name: '192.168.1.1'
```
## Dependencies

  * `puppetlabs/stdlib  >= 2.0.0`
  * `puppetlabs/apt >= 1.0.0`
  * `puppetlabs/concat >=1.0.0`

## License

Apache License 2.0

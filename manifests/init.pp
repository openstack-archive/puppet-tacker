# == Class: tacker
#
# Module for managing tacker config
#
# === Parameters
#
# [*keystone_password*]
#   (required) Password used to authentication.
#
# [*package_ensure*]
#   (optional) Desired ensure state of packages.
#   accepts latest or specific versions.
#   Defaults to present.
#
# [*client_package_ensure*]
#   (optional) Desired ensure state of the client package.
#   accepts latest or specific versions.
#   Defaults to present.
#
# [*bind_host*]
#   (optional) The IP address that tacker binds to.
#   Default to '0.0.0.0'.
#
# [*bind_port*]
#   (optional) Port that tacker binds to.
#   Defaults to '8888'
#
# [*verbose*]
#   (optional) Rather Tacker should log at verbose level.
#   Defaults to undef.
#
# [*debug*]
#   (optional) Rather Tacker should log at debug level.
#   Defaults to undef.
#
# [*auth_type*]
#   (optional) Type is authorization being used.
#   Defaults to 'keystone'
#
# [*auth_uri*]
#   (optional) Complete public Identity API endpoint.
#   Defaults to false.
#
# [*identity_uri*]
#   (optional) Complete admin Identity API endpoint.
#   Defaults to: false
#
# [*keystone_tenant*]
#   (optional) Tenant to authenticate to.
#   Defaults to services.
#
# [*keystone_user*]
#   (optional) User to authenticate as with keystone.
#   Defaults to 'tacker'.
#
# [*manage_service*]
#   (Optional) If Puppet should manage service startup / shutdown.
#   Defaults to true.
#
# [*enabled*]
#  (optional) If the Tacker services should be enabled.
#   Default to true.
#
# [*database_connection*]
#   (optional) Url used to connect to database.
#   Defaults to undef.
#
# [*database_idle_timeout*]
#   (optional) Timeout when db connections should be reaped.
#   Defaults to undef.
#
# [*database_max_retries*]
#   (optional) Maximum number of database connection retries during startup.
#   Setting -1 implies an infinite retry count.
#   (Defaults to undef)
#
# [*database_retry_interval*]
#   (optional) Interval between retries of opening a database connection.
#   (Defaults to undef)
#
# [*database_min_pool_size*]
#   (optional) Minimum number of SQL connections to keep open in a pool.
#   Defaults to: undef
#
# [*database_max_pool_size*]
#   (optional) Maximum number of SQL connections to keep open in a pool.
#   Defaults to: undef
#
# [*database_max_overflow*]
#   (optional) If set, use this value for max_overflow with sqlalchemy.
#   Defaults to: undef
#
# [*rpc_backend*]
#   (Optional) Use these options to configure the RabbitMQ message system.
#   Defaults to 'rabbit'
#
# [*control_exchange*]
#   (Optional)
#   Defaults to 'openstack'.
#
# [*rabbit_host*]
#   (Optional) IP or hostname of the rabbit server.
#   Defaults to '127.0.0.1'
#
# [*rabbit_port*]
#   (Optional) Port of the rabbit server.
#   Defaults to 5672.
#
# [*rabbit_hosts*]
#   (Optional) Array of host:port (used with HA queues).
#   If defined, will remove rabbit_host & rabbit_port parameters from config
#   Defaults to undef.
#
# [*rabbit_userid*]
#   (Optional) User to connect to the rabbit server.
#   Defaults to 'guest'
#
# [*rabbit_password*]
#   (Required) Password to connect to the rabbit_server.
#   Defaults to empty. Required if using the Rabbit (kombu)
#   backend.
#
# [*rabbit_virtual_host*]
#   (Optional) Virtual_host to use.
#   Defaults to '/'
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   (Requires kombu >= 3.0.7 and amqp >= 1.4.0)
#   Defaults to 0
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period to
#   check the heartbeat on RabbitMQ connection.  (i.e. rabbit_heartbeat_rate=2
#   when rabbit_heartbeat_timeout_threshold=60, the heartbeat will be checked
#   every 30 seconds.
#   Defaults to 2
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ
#   Defaults to false
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled).
#   Defaults to $::os_service_default
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions.
#   Defaults to $::os_service_default
#
# [*kombu_reconnect_delay*]
#   (optional) How long to wait before reconnecting in response to an AMQP
#   consumer cancel notification.
#   Defaults to $::os_service_default
#
# [*amqp_durable_queues*]
#   Use durable queues in amqp.
#   (Optional) Defaults to false.
#
# [*service_provider*]
#   (optional) Provider, that can be used for tacker service.
#   Default value defined in tacker::params for given operation system.
#   If you use Pacemaker or another Cluster Resource Manager, you can make
#   custom service provider for changing start/stop/status behavior of service,
#   and set it here.
#
# [*service_name*]
#   (optional) Name of the service that will be providing the
#   server functionality of tacker.
#   Defaults to '$::tacker::params::service_name'
#
# [*sync_db*]
#   (Optional) Run db sync on the node.
#   Defaults to true
#
# [*opendaylight_host*]
#   (Optional) IP or hostname of the opendaylight server.
#   Defaults to '127.0.0.1'
#
# [*opendaylight_port*]
#   (Optional) Port of the opendaylight server.
#   Defaults to 8081 so it doesn't conflict with swift proxy.
#
# [*opendaylight_username*]
#   (Optional) Username to auth to the opendaylight server.
#   Defaults to admin, which is the ODL default.
#
# [*opendaylight_password*]
#   (Optional) Password to auth to the opendaylight server.
#   Defaults to admin, which is the ODL default.
#
# [*heat_uri*]
#   (Optional) Heat URI to access Heat API server.
#   Defaults to false.
#
# == Dependencies
#  None
#
# == Examples
#
#   class { 'tacker':
#     keystone_password   => 'tacker',
#     keystone_tenant     => 'service',
#     auth_uri            => 'http://192.168.122.6:5000/',
#     identity_uri        => 'http://192.168.122.6:35357/',
#     database_connection => 'mysql://tacker:password@192.168.122.6/tacker',
#     rabbit_host         => '192.168.122.6',
#     rabbit_password     => 'guest',
#   }
#   
#   class { 'tacker::db::mysql':
#       password => 'password',
#       host => '192.168.122.6',
#   } 
#   
#   class { 'tacker::keystone::auth':
#     password            => 'tacker',
#     tenant              => 'service',
#     admin_url           => 'http://192.168.122.6:8888',
#     internal_url        => 'http://192.168.122.6:8888',
#     public_url          => 'http://192.168.122.6:8888',
#     region              => 'regionOne',
#   }
#
# == Authors
#
#   Dan Radez <dradez@redhat.com>
#   Tim Rozet <trozet@redhat.com>
# == Copyright
#
# Copyright 2015 Red Hat Inc, unless otherwise noted.
#

class tacker(
  $keystone_password,
  $package_ensure                     = 'present',
  $client_package_ensure              = 'present',
  $bind_host                          = '0.0.0.0',
  $bind_port                          = '8888',
  $verbose                            = undef,
  $debug                              = undef,
  $auth_type                          = 'keystone',
  $auth_uri                           = false,
  $identity_uri                       = false,
  $keystone_tenant                    = 'services',
  $keystone_user                      = 'tacker',
  $manage_service                     = true,
  $enabled                            = true,
  $database_connection                = undef,
  $database_idle_timeout              = undef,
  $database_max_retries               = undef,
  $database_retry_interval            = undef,
  $database_min_pool_size             = undef,
  $database_max_pool_size             = undef,
  $database_max_overflow              = undef,
  $sync_db                            = true,
  $rpc_backend                        = 'rabbit',
  $control_exchange                   = 'tacker',
  $rabbit_host                        = '127.0.0.1',
  $rabbit_port                        = 5672,
  $rabbit_hosts                       = false,
  $rabbit_virtual_host                = '/',
  $rabbit_heartbeat_timeout_threshold = 0,
  $rabbit_heartbeat_rate              = 2,
  $rabbit_userid                      = 'guest',
  $rabbit_password                    = false,
  $rabbit_use_ssl                     = false,
  $kombu_ssl_ca_certs                 = $::os_service_default,
  $kombu_ssl_certfile                 = $::os_service_default,
  $kombu_ssl_keyfile                  = $::os_service_default,
  $kombu_ssl_version                  = $::os_service_default,
  $kombu_reconnect_delay              = $::os_service_default,
  $amqp_durable_queues                = false,
  $service_provider                   = $::tacker::params::service_provider,
  $service_name                       = $::tacker::params::service_name,
  $opendaylight_host                  = '127.0.0.1',
  $opendaylight_port                  = 8081,
  $opendaylight_username              = 'admin',
  $opendaylight_password              = 'admin',
  $heat_uri                           = false,
) inherits tacker::params {
  tacker_config {
    'DEFAULT/service_plugins'         : value => 'tacker.vm.plugin.VNFMPlugin,tacker.sfc.plugin.SFCPlugin,tacker.sfc_classifier.plugin.SFCCPlugin';
    'servicevm/infra_driver'          : value => 'heat';
    'servicevm_heat/stack_retries'    : value => '10';
    'servicevm_heat/stack_retry_wait' : value => '30';
    'sfc/infra_driver'                : value => 'opendaylight';
    'sfc_opendaylight/ip'             : value => $opendaylight_host;
    'sfc_opendaylight/port'           : value => $opendaylight_port;
    'sfc_opendaylight/username'       : value => $opendaylight_username;
    'sfc_opendaylight/password'       : value => $opendaylight_password;
  }

  if $identity_uri {
    tacker_config { 'keystone_authtoken/identity_uri': value => $identity_uri; }
    tacker_config { 'keystone_authtoken/auth_url'    : value => $identity_uri; }
  } else {
    tacker_config { 'keystone_authtoken/identity_uri': ensure => absent; }
  }

  if $auth_uri {
    tacker_config { 'keystone_authtoken/auth_uri': value => $auth_uri; }
  } else {
    tacker_config { 'keystone_authtoken/auth_uri': ensure => absent; }
  }

  if $heat_uri {
    tacker_config { 'servicevm_heat/heat_uri': value => $heat_uri; }
  }

  if $auth_type == 'keystone' {
    tacker_config {
      'keystone_authtoken/project_name' : value => $keystone_tenant;
      'keystone_authtoken/username'     : value => $keystone_user;
      'keystone_authtoken/password'     : value => $keystone_password, secret => true;
    }
  }

  Tacker_config<||> ~> Service[$service_name]
  Tacker_config<||> ~> Exec<| title == 'tacker-manage db_sync'|>

  include ::tacker::db
  include ::tacker::params

  if $sync_db {
    include ::tacker::db::sync
    Class['::tacker::db::sync'] ~> Service[$service_name]
  }
  if $rpc_backend == 'rabbit' {

    if ! $rabbit_password {
      fail('Please specify a rabbit_password parameter.')
    }

    tacker_config {
      'DEFAULT/rabbit_password':              value => $rabbit_password, secret => true;
      'DEFAULT/rabbit_userid':                value => $rabbit_userid;
      'DEFAULT/rabbit_virtual_host':          value => $rabbit_virtual_host;
      'DEFAULT/control_exchange':             value => $control_exchange;
      #'DEFAULT/rabbit_use_ssl':               value => $rabbit_use_ssl;
      #'DEFAULT/kombu_reconnect_delay':        value => $kombu_reconnect_delay;
      #'DEFAULT/heartbeat_timeout_threshold':  value => $rabbit_heartbeat_timeout_threshold;
      #'DEFAULT/heartbeat_rate':               value => $rabbit_heartbeat_rate;
      #'DEFAULT/amqp_durable_queues':          value => $amqp_durable_queues;
    }

    if $rabbit_use_ssl {
      tacker_config {
        'DEFAULT/kombu_ssl_version'  : value => $kombu_ssl_version;
        'DEFAULT/kombu_ssl_ca_certs' : value => $kombu_ssl_ca_certs;
        'DEFAULT/kombu_ssl_certfile' : value => $kombu_ssl_certfile;
        'DEFAULT/kombu_ssl_keyfile'  : value => $kombu_ssl_keyfile;
      }
    }

    if $rabbit_hosts {
      tacker_config { 'DEFAULT/rabbit_hosts':     value => join($rabbit_hosts, ',') }
      tacker_config { 'DEFAULT/rabbit_ha_queues': value => true }
      tacker_config { 'DEFAULT/rabbit_host':      ensure => absent }
      tacker_config { 'DEFAULT/rabbit_port':      ensure => absent }
    } else {
      tacker_config { 'DEFAULT/rabbit_host':      value => $rabbit_host }
      tacker_config { 'DEFAULT/rabbit_port':      value => $rabbit_port }
      tacker_config { 'DEFAULT/rabbit_hosts':     value => "${rabbit_host}:${rabbit_port}" }
      tacker_config { 'DEFAULT/rabbit_ha_queues': value => false }
    }

  }

  package { 'tacker':
    ensure => $package_ensure,
    name   => $::tacker::params::package_name,
    tag    => ['openstack', 'tacker-package'],
  }
  if $client_package_ensure == 'present' {
    include '::tacker::client'
  } else {
    class { '::tacker::client':
      ensure => $client_package_ensure,
    }
  }

  group { 'tacker':
    ensure  => present,
    system  => true,
    require => Package['tacker'],
  }

  user { 'tacker':
    ensure  => 'present',
    gid     => 'tacker',
    system  => true,
    require => Package['tacker'],
  }

  file { ['/etc/tacker', '/var/log/tacker', '/var/lib/tacker']:
    ensure  => directory,
    mode    => '0750',
    owner   => 'tacker',
    group   => 'tacker',
    require => Package['tacker'],
    notify  => Service[$service_name],
  }

  file { '/etc/tacker/tacker.conf':
    ensure  => present,
    mode    => '0600',
    owner   => 'tacker',
    group   => 'tacker',
    require => Package['tacker'],
    notify  => Service[$service_name],
  }

  tacker_config {
    'DEFAULT/bind_host': value => $bind_host;
    'DEFAULT/bind_port': value => $bind_port;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }
  }

  class { '::tacker::service':
    ensure       => $service_ensure,
    service_name => $service_name,
    enable       => $enabled,
    hasstatus    => true,
    hasrestart   => true,
    provider     => $service_provider,
  }
}

# = Class: tacker::server
#
# This class manages the Tacker server.
#
# [*enabled*]
#   (Optional) Service enable state for tacker-server.
#   Defaults to true.
#
# [*manage_service*]
#   (Optional) Whether the service is managed by this puppet class.
#   Defaults to true.
#
# [*auth_strategy*]
#   (optional) Type of authentication to be used.
#   Defaults to 'keystone'
#
# [*bind_host*]
#   (optional) The host IP to bind to.
#   Defaults to $::os_service_default
#
# [*bind_port*]
#   (optional) The port to bind to.
#   Defaults to $::os_service_default
#
# [*api_workers*]
#   (optional) Number of separate worker process for service.
#   Defaults to $::os_workers
#
# [*allow_bulk*]
#   (Optional) Allow the usage of the bulk API.
#   Defaults to $::os_service_default
#
# [*allow_pagination*]
#   (Optional) Allow the usage of the pagination.
#   Defaults to $::os_service_default
#
# [*allow_sorting*]
#   (Optional) Allow the usage of the sorting.
#   Defaults to $::os_service_default
#
# [*pagination_max_limit*]
#   (Optional) The maximum number of items returned in a single response.
#   Defaults to $::os_service_default
#
# [*package_ensure*]
#   (Optional) Ensure state for package.
#   Defaults to 'present'
#
class tacker::server(
  $manage_service       = true,
  $enabled              = true,
  $auth_strategy        = 'keystone',
  $bind_host            = $::os_service_default,
  $bind_port            = $::os_service_default,
  $api_workers          = $::os_workers,
  $allow_bulk           = $::os_service_default,
  $allow_pagination     = $::os_service_default,
  $allow_sorting        = $::os_service_default,
  $pagination_max_limit = $::os_service_default,
  $package_ensure       = 'present',
) {

  include tacker::deps
  include tacker::params
  include tacker::policy

  if $auth_strategy == 'keystone' {
    include tacker::keystone::authtoken
  }

  ensure_packages('tacker-server', {
    ensure => $package_ensure,
    name   => $::tacker::params::package_name,
    tag    => ['openstack', 'tacker-package'],
  })

  tacker_config {
    'DEFAULT/auth_strategy':        value => $auth_strategy;
    'DEFAULT/bind_host':            value => $bind_host;
    'DEFAULT/bind_port':            value => $bind_port;
    'DEFAULT/api_workers':          value => $api_workers;
    'DEFAULT/allow_bulk':           value => $allow_bulk;
    'DEFAULT/allow_pagination':     value => $allow_pagination;
    'DEFAULT/allow_sorting':        value => $allow_sorting;
    'DEFAULT/pagination_max_limit': value => $pagination_max_limit;
  }

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }

    service { 'tacker-server':
      ensure => $service_ensure,
      name   => $::tacker::params::server_service_name,
      enable => $enabled,
      tag    => 'tacker-service'
    }
  }

}

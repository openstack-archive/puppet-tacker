# = Class: tacker::conductor
#
# This class manages the Tacker conductor.
#
# [*enabled*]
#   (Optional) Service enable state for tacker-conductor.
#   Defaults to true.
#
# [*manage_service*]
#   (Optional) Whether the service is managed by this puppet class.
#   Defaults to true.
#
# [*package_ensure*]
#   (Optional) Ensure state for package.
#   Defaults to 'present'
#
class tacker::conductor(
  $manage_service = true,
  $enabled        = true,
  $package_ensure = 'present',
) {

  include tacker::deps
  include tacker::params

  ensure_packages('tacker-server', {
    ensure => $package_ensure,
    name   => $::tacker::params::package_name,
    tag    => ['openstack', 'tacker-package'],
  })

  if $manage_service {
    if $enabled {
      $service_ensure = 'running'
    } else {
      $service_ensure = 'stopped'
    }

    service { 'tacker-conductor':
      ensure => $service_ensure,
      name   => $::tacker::params::conductor_service_name,
      enable => $enabled,
      tag    => 'tacker-service'
    }
  }

}

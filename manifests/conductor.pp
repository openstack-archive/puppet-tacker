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
# [*report_interval*]
#   (Optional) Seconds between running components report states.
#   Defaults to $::os_service_default.
#
# [*periodic_interval*]
#   (Optional) Seconds between running periodic tasks.
#   Defaults to $::os_service_default.
#
# [*periodic_fuzzy_delay*]
#   (Optional) Range of seconds to randomly delay when starting the periodic
#   task scheduler to reduce stampeding.
#   Defaults to $::os_service_default.
#
class tacker::conductor(
  $manage_service       = true,
  $enabled              = true,
  $package_ensure       = 'present',
  $report_interval      = $::os_service_default,
  $periodic_interval    = $::os_service_default,
  $periodic_fuzzy_delay = $::os_service_default,
) {

  include tacker::deps
  include tacker::params

  ensure_packages('tacker-server', {
    ensure => $package_ensure,
    name   => $::tacker::params::package_name,
    tag    => ['openstack', 'tacker-package'],
  })

  tacker_config {
    'DEFAULT/report_interval':      value => $report_interval;
    'DEFAULT/periodic_interval':    value => $periodic_interval;
    'DEFAULT/periodic_fuzzy_delay': value => $periodic_fuzzy_delay;
  }

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

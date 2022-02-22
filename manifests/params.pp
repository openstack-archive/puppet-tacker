# Parameters for puppet-tacker
#
class tacker::params {
  include openstacklib::defaults

  $user                = 'tacker'
  $group               = 'tacker'
  $client_package_name = 'python3-tackerclient'

  case $::osfamily {
    'RedHat': {
      $package_name           = 'openstack-tacker'
      $server_service_name    = 'openstack-tacker-server'
      $conductor_service_name = 'openstack-tacker-conductor'
    }
    'Debian': {
      $package_name           = 'tacker'
      $server_service_name    = 'tacker'
      $conductor_service_name = 'tacker-conductor'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, \
module ${module_name} only support osfamily RedHat and Debian")
    } # Case $::osfamily
  }
}

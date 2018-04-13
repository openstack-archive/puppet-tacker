# Parameters for puppet-tacker
#
class tacker::params {
  include ::openstacklib::defaults
  $group = 'tacker'

  if ($::os_package_type == 'debian') {
    $pyvers = '3'
  } else {
    $pyvers = ''
  }

  $client_package_name = "python${pyvers}-tackerclient"
  case $::osfamily {
    'RedHat': {
      $package_name     = 'openstack-tacker'
      $service_name     = 'openstack-tacker-server'
    }
    'Debian': {
      $package_name     = 'tacker'
      $service_name     = 'tacker'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    } # Case $::osfamily
  }
}

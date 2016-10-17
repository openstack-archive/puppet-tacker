# Parameters for puppet-tacker
#
class tacker::params {
  include ::openstacklib::defaults

  $client_package_name = 'python-tackerclient'
  case $::osfamily {
    'RedHat': {
      $package_name                 = 'openstack-tacker'
      $service_name                 = 'tacker-server'
      $service_provider             = undef
    }
    'Debian': {
      $package_name                 = 'tacker'
      $service_name                 = 'tacker'
      $service_provider             = undef
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    } # Case $::osfamily
  }
}

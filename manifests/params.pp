#
# This class contains the platform differences for tacker
#
class tacker::params {
  $client_package_name = 'python-tackerclient'

  case $::osfamily {
    'Debian': {
      $package_name                 = 'tacker'
      $service_name                 = 'tacker'
      $python_memcache_package_name = 'python-memcache'
      $sqlite_package_name          = 'python-pysqlite2'
      $paste_config                 = undef
      case $::operatingsystem {
        'Debian': {
          $service_provider            = undef
        }
        default: {
          $service_provider            = 'upstart'
        }
      }
    }
    'RedHat': {
      $package_name                 = 'openstack-tacker'
      $service_name                 = 'openstack-tacker'
      $python_memcache_package_name = 'python-memcached'
      $sqlite_package_name          = undef
      $service_provider             = undef
    }
  }
}

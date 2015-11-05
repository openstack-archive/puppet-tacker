# == Class: tacker::client
#
# Installs Tacker client.
#
# === Parameters
#
# [*ensure*]
#   (optional) Ensure state of the package.
#   Defaults to 'present'.
#
class tacker::client (
  $ensure = 'present'
) {

  package { 'python-tackerclient':
    ensure => $ensure,
    tag    => 'openstack',
  }

  if $ensure == 'present' {
    include '::openstacklib::openstackclient'
  } else {
    class { '::openstacklib::openstackclient':
      package_ensure => $ensure,
    }
  }
}

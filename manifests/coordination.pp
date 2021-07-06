# == Class: tacker::coordination
#
# Setup and configure Tacker coordination settings.
#
# === Parameters
#
# [*backend_url*]
#   (Optional) Coordination backend URL.
#   Defaults to $::os_service_default
#
class tacker::coordination (
  $backend_url = $::os_service_default,
) {

  include tacker::deps

  oslo::coordination{ 'tacker_config':
    backend_url => $backend_url
  }
}

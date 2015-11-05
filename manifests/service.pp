# == Class tacker::service
#
# Encapsulates the tacker service to a class.
# This allows resources that require tacker to
# require this class, which can optionally
# validate that the service can actually accept
# connections.
#
# === Parameters
#
# [*ensure*]
#   (optional) The desired state of the tacker service
#   Defaults to undef
#
# [*service_name*]
#   (optional) The name of the tacker service
#   Defaults to $::tacker::params::service_name
#
# [*enable*]
#   (optional) Whether to enable the tacker service
#   Defaults to true
#
# [*hasstatus*]
#   (optional) Whether the tacker service has status
#   Defaults to true
#
# [*hasrestart*]
#   (optional) Whether the tacker service has restart
#   Defaults to true
#
# [*provider*]
#   (optional) Provider for tacker service
#   Defaults to $::tacker::params::service_provider
#
class tacker::service(
  $ensure         = undef,
  $service_name   = $::tacker::params::service_name,
  $enable         = true,
  $hasstatus      = true,
  $hasrestart     = true,
  $provider       = $::tacker::params::service_provider,
) {
  include ::tacker::params

  service { 'tacker':
    ensure     => $ensure,
    name       => $service_name,
    enable     => $enable,
    hasstatus  => $hasstatus,
    hasrestart => $hasrestart,
    provider   => $provider,
    tag        => 'tacker-service',
  }

}

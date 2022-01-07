# = Class: tacker::vnf_lcm
#
# This class manages the Tacker vnf_lcm.
#
# [*endpoint_url*]
#  (Optional) Endpoint URL.
#  Defaults to $::os_service_default
#
# [*subscription_num*]
#  (Optional) Number of subscriptions.
#  Defaults to $::os_service_default
#
# [*retry_num*]
#  (Optional) Number of retry.
#  Defaults to $::os_service_default
#
# [*retry_wait*]
#  (Optional) Retry interval(sec).
#  Defaults to $::os_service_default
#
# [*retry_timeout*]
#  (Optional) Retry timeout(sec).
#  Defaults to $::os_service_default
#
# [*test_callback_uri*]
#  (Optional) Test callbackUri.
#  Defaults to $::os_service_default
#
class tacker::vnf_lcm(
  $endpoint_url      = $::os_service_default,
  $subscription_num  = $::os_service_default,
  $retry_num         = $::os_service_default,
  $retry_wait        = $::os_service_default,
  $retry_timeout     = $::os_service_default,
  $test_callback_uri = $::os_service_default,
) {

  include tacker::deps
  include tacker::params

  tacker_config {
    'vnf_lcm/endpoint_url':      value => $endpoint_url;
    'vnf_lcm/subscription_num':  value => $subscription_num;
    'vnf_lcm/retry_num':         value => $retry_num;
    'vnf_lcm/retry_wait':        value => $retry_wait;
    'vnf_lcm/retry_timeout':     value => $retry_timeout;
    'vnf_lcm/test_callback_uri': value => $test_callback_uri;
  }
}

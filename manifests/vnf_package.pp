# = Class: tacker::vnf_package
#
# This class manages the Tacker vnf_package.
#
# [*vnf_package_csar_path*]
#  (Optional) Path to store extracted CSAR file.
#  Defaults to $::os_service_default
#
# [*csar_file_size_cap*]
#  (Optional) Maximum size of CSAR file a user can upload in GB.
#  Defaults to $::os_service_default
#
# [*hashing_algorithm*]
#  (Optional) Secure hashing algorithm used for computing the 'hash' property.
#  Defaults to $::os_service_default
#
# [*get_top_list*]
#  (Optional) List of items to get from top-vnfd.
#  Defaults to $::os_service_default
#
# [*exclude_node*]
#  (Optional) Exclude node from node_template.
#  Default to $::os_service_default
#
# [*get_lower_list*]
#  (Optional) List of types to get from lower-vnfd.
#  Defaults to $::os_service_default
#
# [*del_input_list*]
#  (Optional) List of del inputs from lower-vnfd
#  Defaults to $::os_service_default
#
class tacker::vnf_package(
  $vnf_package_csar_path = $::os_service_default,
  $csar_file_size_cap    = $::os_service_default,
  $hashing_algorithm     = $::os_service_default,
  $get_top_list          = $::os_service_default,
  $exclude_node          = $::os_service_default,
  $get_lower_list        = $::os_service_default,
  $del_input_list        = $::os_service_default,
) {

  include tacker::deps
  include tacker::params

  tacker_config {
    'vnf_package/vnf_package_csar_path': value => $vnf_package_csar_path;
    'vnf_package/csar_file_size_cap':    value => $csar_file_size_cap;
    'vnf_package/hashing_algorithm':     value => $hashing_algorithm;
    'vnf_package/get_top_list':          value => join(any2array($get_top_list), ',');
    'vnf_package/exclude_node':          value => join(any2array($exclude_node), ',');
    'vnf_package/get_lower_list':        value => join(any2array($get_lower_list), ',');
    'vnf_package/del_input_list':        value => join(any2array($del_input_list), ',');
  }
}

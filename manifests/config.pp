# == Class: tacker::config
#
# This class is used to manage arbitrary tacker configurations.
#
# === Parameters
#
# [*tacker_config*]
#   (optional) Allow configuration of arbitrary tacker configurations.
#   The value is an hash of tacker_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   tacker_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
# [*tacker_api_paste_ini*]
#   (optional) Allow configuration of /etc/tacker/api-paste.ini options.
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class tacker::config (
  $tacker_config        = {},
  $tacker_api_paste_ini = {},
) {

  include tacker::deps

  validate_legacy(Hash, 'validate_hash', $tacker_config)
  validate_legacy(Hash, 'validate_hash', $tacker_api_paste_ini)

  create_resources('tacker_config', $tacker_config)
  create_resources('tacker_api_paste_ini', $tacker_api_paste_ini)
}

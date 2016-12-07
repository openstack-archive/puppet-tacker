#
# Class to execute tacker-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the tacker-dbsync command.
#   Defaults to undef
#
class tacker::db::sync(
  $extra_params  = undef,
) {

  include ::tacker::deps

  exec { 'tacker-db-sync':
    command     => "tacker-manage db_sync ${extra_params}",
    path        => '/usr/bin',
    user        => 'tacker',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    subscribe   => [
      Anchor['tacker::install::end'],
      Anchor['tacker::config::end'],
      Anchor['tacker::dbsync::begin']
    ],
    notify      => Anchor['tacker::dbsync::end'],
  }

}

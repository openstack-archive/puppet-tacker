# == Class: tacker::db::postgresql
#
# Class that configures postgresql for tacker
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'tacker'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'tacker'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class tacker::db::postgresql(
  $password,
  $dbname     = 'tacker',
  $user       = 'tacker',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  Class['tacker::db::postgresql'] -> Service<| title == 'tacker' |>

  ::openstacklib::db::postgresql { 'tacker':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['tacker'] ~> Exec<| title == 'tacker-manage db_sync' |>

}

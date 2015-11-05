#
# Class to execute "tacker-manage db_sync
#
class tacker::db::sync {
  exec { 'tacker-manage db_sync':
    path        => '/usr/bin',
    user        => 'tacker',
    refreshonly => true,
    subscribe   => [Package['tacker'], Tacker_config['database/connection']],
    require     => User['tacker'],
  }

  Exec['tacker-manage db_sync'] ~> Service<| title == 'tacker' |>
}

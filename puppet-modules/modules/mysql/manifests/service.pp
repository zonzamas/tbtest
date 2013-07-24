class mysql::service {
  service { 'mysqld':
    ensure    => 'running',
    enable    => 'true',
    name      => $mysql::params::mysql_daemon,
    hasstatus => true,
    require   => Class[mysql::install]
  }
}

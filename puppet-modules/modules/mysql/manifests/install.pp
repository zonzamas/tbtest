class mysql::install {
  package {'mysql-server':
      ensure => installed,
      name   => $mysql::params::mysql_server;
  }
}

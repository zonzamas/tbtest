class mysql::postconfig {
  exec {'setup_mysql_pass_root':
    command => "/usr/bin/mysqladmin -uroot -h localhost password $mysql::rootpass",
    onlyif  => '/usr/bin/mysql -uroot -h localhost',
  }
}

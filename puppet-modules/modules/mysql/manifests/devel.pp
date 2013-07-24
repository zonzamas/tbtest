class mysql::devel inherits mysql::params{
  package{'mysql-dev':
    ensure => installed,
    name   => $mysql::params::mysql_dev,
  }
}

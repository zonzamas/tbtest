class mysql::params {
  $rootpass             = hiera('mysql_root_pass')
  $mysql_user           = 'mysql'
  $mysql_group          = 'mysql'
  $mysql_datadir        = hiera('mysql_datadir')

  case $::operatingsystem {
    centos,redhat :{
      $mysql_server         = "mysql-server.${::hardwaremodel}"
      $mysql_client         = "mysql.${::hardwaremodel}"
      $mysql_dev            = "mysql-devel.${::hardwaremodel}"
      $mysql_daemon         = 'mysqld'
    }
    debian,ubuntu :{
      $mysql_server         = 'mysql-server'
      $mysql_client         = 'mysql-client'
      $mysql_dev            = 'libmysqlclient15-dev'
      $mysql_daemon         = 'mysql'
    }
    sles:{
      $mysql_server         = 'mysql'
      $mysql_client         = 'mysql-client'
      $mysql_dev            = 'libmysqlclient-devel'
      $mysql_daemon         = 'mysql'
      notify{"Only mysql client is supported in SUSE SLES.":}
    }
    default: {
      fail("Operating system $operatingsystem is not supported")
    }
  }
}

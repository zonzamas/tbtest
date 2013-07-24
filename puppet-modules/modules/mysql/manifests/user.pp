define mysql::user (
  $pass     = 'StdPas5',
  $rootpass = "${mysql::rootpass}",
  $server   = 'localhost',
  $host     = 'localhost'
  ){
    exec {
      "add_mysql_user_${name}":
        command => "mysql -uroot -p$rootpass -h \"$server\" -e \"create user '$name'@'$host' identified by '$pass'\"",
        path    => '/usr/bin:/bin:/sbin',
        unless  => "mysql -uroot -p$rootpass -h$server -e \"use mysql;select user,host from user;\"|grep $host|grep $name",
        onlyif  => "mysql -uroot -p$rootpass -h$server -e \"show status\"",
        require => [Class[mysql],Class[mysql::service]]
    }
  }
  

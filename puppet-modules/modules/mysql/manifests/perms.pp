#This define is not intended to be called directly but via mysql::db
define mysql::perms(
  $user     = $name,
  $table    = '*',
  $perms    = 'all privileges',
  $db       = '',
  $rootpass = "${mysql::rootpass}",
  $server   = 'localhost',
  $host     = 'localhost'
  ) {

  exec{"set_perms_$name":
    command => "mysql -uroot -p$rootpass -h $server -e \"grant $perms on $db.$table to '$user'@'$host'\"",
    path    => '/usr/bin:/bin:/sbin',
    onlyif  => "mysql -uroot -p$rootpass -h$server -e \"show status\"",
    require => [Mysql::User[$user]]
    #unless => "mysql -uroot -p$rootpass -h $server -e \"select * from information_schema.user_privileges\"|grep $mysql::dbname";
  }

}

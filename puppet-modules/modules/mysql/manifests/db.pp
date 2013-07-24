define mysql::db (
  $db       = $name,
  $user     = 'root',
  $host     = 'localhost',
  $server   = 'localhost',
  $rootpass = "${mysql::rootpass}",
  $perms    = 'all privileges',
  $table    = '*',
){
  exec {
    "create_db_$db":
      command     => "mysqladmin -uroot -p$rootpass -h \"$server\" create \"$db\"",
      path        => '/usr/bin:/bin:/sbin',
      onlyif      => "mysql -uroot -p$rootpass -h$server -e \"show status\"",
      unless      => "mysql -uroot -p$rootpass -h \"$server\" -e 'use $db'";

    "set_perms_$db":
      command     => "mysql -uroot -p$rootpass -h $server -e \"grant $perms on $db.$table to '$user'@'$host'\"",
      path        => '/usr/bin:/bin:/sbin',
      onlyif  => "mysql -uroot -p$rootpass -h$server -e \"show status\"",
      #unless  => "mysql -uroot -p$rootpass -h $server -e \"select * from information_schema.user_privileges\"|grep $mysql::dbdb";
  }
}

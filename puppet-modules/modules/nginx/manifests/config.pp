class nginx::config (
  $app_home = $nginx::app_home
  ){
  file{$nginx::params::config_file:
    ensure => present,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
    content => template("${module_name}/nginx.conf.erb")
  }
}

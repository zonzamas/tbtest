class nginx (
  $app_home = $nginx::params::app_home
) inherits nginx::params {
  anchor{'nginx::begin':}
  class{'nginx::install':
    require => Anchor['nginx::begin']
  }
  class{'nginx::config':
    app_home => $app_home,
    require  => Class['nginx::install'],
    notify   => Class['nginx::service']
  }
  class{'nginx::service':
    require => Class['nginx::config'] , 
    before  => Anchor['nginx::end']
  }
  anchor{'nginx::end':}
}

class mysql (
  $rootpass  = $mysql::params::rootpass,
  ) inherits mysql::params {

  anchor{'mysql::begin':
    before  => Class['mysql::install'],
  }
  class{'mysql::install':
    before   => Class['mysql::devel'],
    require  => Anchor['mysql::begin'],
  }
  class{'mysql::devel':
    before    => Class['mysql::service'],
    require   => Class['mysql::install'],
  }
  class{'mysql::service':
    before  => Class['mysql::postconfig'],
    require => Class['mysql::install'],
  }
  class{'mysql::postconfig':
    before  => Anchor['mysql::end'],
    require => Class['mysql::service'],
  }
  anchor{'mysql::end':
    require => Class['mysql::postconfig']
  }
}

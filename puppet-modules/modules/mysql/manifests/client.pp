class mysql::client inherits mysql::params {

  anchor{'mysql::client::begin':
    before  => Class['mysql::client::install'],
  }
  class{'mysql::client::install':
   require  => Anchor['mysql::client::begin'],
  }
  anchor{'mysql::client::end':
    require => Class['mysql::client::install']
  }
}

class base (
  $app_home = '/var/www2/current',
  $app_base = '/var/www2',
  $user     = 'vagrant'
  ){
    include nodejs
    include devtools
    include bundler
    
    class{'directories':
      app_base => $app_base,
      user     => $user
    }
    
    class{'nginx':
      app_home => $app_home,
    }
    
    # Lets bundler/capistrano handle this
    #class{'unicorn':
      #  app_home => '/var/www/current'
      #}
    
    include mysql
    
    $dgtuser = hiera('dgtuser')
    $dgtpass = hiera('dgtpass')
    $dgtdb   = hiera('dgtdb')
    
    mysql::user { $dgtuser:
      pass    => $dgtpass,
      host    => 'localhost',
    }
    mysql::db { $dgtdb:
      user    => $dgtuser,
      host    => '%',
      require => Class['mysql']
    }
    
    #TODO a module to handle this properly instead of 
    # just disabling everything
    exec{'disable-iptables-rules':
      command => '/sbin/iptables -F'
    } 
    
}

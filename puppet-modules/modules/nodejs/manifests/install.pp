class nodejs::install {
  package{$nodejs::params::node_pkg:
    ensure => present
  }
}

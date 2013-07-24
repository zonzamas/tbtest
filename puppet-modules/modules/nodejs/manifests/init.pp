# Class: nodejs
#
# Parameters:
#
# Actions:
#
# Requires:
#
#  Yumrepo['internal'] (virtual)
#
# Usage:
# [Remember: No empty lines between comments and class definition]
class nodejs(
  $version        = $nodejs::params::version,
) inherits nodejs::params {
  anchor{'nodejs::begin':
    before => Class['nodejs::install']
  }
  class{'nodejs::install':
    require => Anchor['nodejs::begin']
  }
  anchor{'nodejs::end':
    require => Class['nodejs::install']
  }
}

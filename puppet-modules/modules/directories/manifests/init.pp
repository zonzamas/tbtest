class directories(
  $user = 'vagrant',
  $group = $user,
  $app_base = undef
)
{
  if ! $app_base {
    fail('You forgot to set an app_base')
  }
  exec{'mkdir-p':
    command=> "/bin/mkdir -p ${app_base}"
  }
  
  file{$app_base:
    ensure  => directory,
    mode    => '0755',
    owner   => $user,
    group   => $group,
    require => Exec['mkdir-p']
  }
  
}

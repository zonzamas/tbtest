# Define: nodejs::npm
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Usage:
#
define nodejs::npm (
  $ensure      = present,
  $version     = undef,
  $source      = undef,
  $install_opt = undef,
  $remove_opt  = undef,
  $npm_dir     = $nodejs_modules,
  $publish     = false,
  $daemon      = false,
  $index       = ''
) {
  include nodejs

  $npm_pkg = $name

  if $source {
    $install_pkg = $source
  } elsif $version {
    $install_pkg = "${npm_pkg}@${version}"
  } else {
    $install_pkg = $npm_pkg
  }

  if $version {
    $validate = "${npm_dir}/${npm_pkg}:${npm_pkg}@${version}"
  } else {
    $validate = "${npm_dir}/${npm_pkg}"
  }

  if $ensure == present {
    exec { "npm_install_${name}":
      command => "npm install ${install_opt} ${install_pkg}",
      unless  => "npm list -p -l | grep '${validate}'",
      cwd     => $npm_dir,
      path    => $::path,
      require => Class['nodejs'],
    }

    if $publish == true {
      exec { "npm_publish_install_${name}":
        command => "npm install",
        cwd     => "${npm_dir}/${name}",
        path    => $::path,
        require => Exec["npm_install_${name}"],
      }
    }

    if $daemon == true {
      file { "npm_init_${name}":
        ensure  => file,
        path    => "/etc/init.d/${name}",
        content => template("${module_name}/nodejs-init-module.erb"),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
      }
    }

    # Conditionally require npm_proxy only if resource exists.
    Exec<| title=='npm_proxy' |> -> Exec["npm_install_${name}"]
  } else {
    exec { "npm_remove_${name}":
      command => "npm remove ${npm_pkg}",
      onlyif  => "npm list -p -l | grep '${validate}'",
      cwd     => $npm_dir,
      path    => $::path,
      require => Class['nodejs'],
    }
  }
}

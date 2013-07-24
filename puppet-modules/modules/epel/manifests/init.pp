class epel {
      #TODO a module that handles packages that are not in the standard repo and/or a custom repo
      exec{'download_and_install_epel':
        command => "/usr/bin/wget --quiet https://www.dropbox.com/s/pugvpttdvm8rld5/epel-release-6-8.noarch.rpm -O epel.rpm && rpm -Uvh epel.rpm --force",
	unless  => "/bin/rpm -q epel-release"
      }	
}     
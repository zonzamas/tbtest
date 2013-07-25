Vagrant.configure("2") do |config|
 config.vm.box = "CentOS 6.4 x86_64 Minimal"

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.
 config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"


  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 80, host: 8081

   #Vagrant bootstraping
  config.vm.provision :shell do |shell|
     shell.inline = "
     rpm -q epel-release-6-8.noarch || (wget --quiet https://www.dropbox.com/s/pugvpttdvm8rld5/epel-release-6-8.noarch.rpm -O epel.rpm && rpm -Uvh epel.rpm --force)
     rpm -q zlib-devel || rpm yum install zlib-devel -y
     rpm -q libyaml || yum install libyaml -y
     rpm -q ruby-1.9.3p448-1.el6.x86_64 || (wget --quiet https://www.dropbox.com/s/9mvb9sedc73xkzb/ruby-1.9.3p448-1.el6.x86_64.rpm -O ruby.rpm && rpm -Uvh ruby.rpm --force --nodeps)
     (gem list puppet | grep puppet) || gem install puppet --no-ri --no-rdoc"
  end

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet-modules/manifests"
     puppet.manifest_file  = "app.pp"
     puppet.options        = "--hiera_config /tmp/vagrant-puppet/manifests/hiera.yaml"
     puppet.module_path    = "puppet-modules/modules"
   end

end

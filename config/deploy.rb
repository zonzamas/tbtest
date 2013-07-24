# -*- coding: utf-8 -*-
require 'bundler/capistrano'
require 'capistrano-unicorn'

set :application, "teambox-test"
set :repository, "."
set :scm, :none
set :deploy_to, "/var/www2"
set :deploy_via, :copy
set :use_sudo, false
set :normalize_asset_timestamps, false
set :copy_exclude, [".git/*", "cli/*", "puppet-modules/*"]
default_run_options[:pty] = true

#set :user, "ec2-user"
#ssh_options[:keys] = ["/Users/zonzamas/devel/vagrant/zonzamas.pem"]
#server "ec2-54-229-31-105.eu-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true

set :user, "vagrant"
ssh_options[:port] = 2222
ssh_options[:keys] = "~/.vagrant.d/insecure_private_key"
server "localhost", :app, :web, :db, :primary => true

after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded


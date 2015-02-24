#
# Cookbook Name:: base
# Recipe:: default
#

Chef::Log.info('Starting base::default')

include_recipe "apt"

execute "apt-mark-hold" do
  command "apt-mark hold grub-pc grub-pc-bin grub2-common && apt-get update"
  action :nothing
end

execute "apt-upgrade" do
  command "apt-get update && apt-get upgrade -y"
  action :nothing
  only_if { node['config']['drupical']['os_update'] }
end

execute "apt-cleanup" do
  command "apt-get -y autoremove && apt-get -y clean"
  action :nothing
end

template "/etc/apt/apt.conf.d/90forceyes" do
  source "90forceyes"
  mode '0666'
  notifies :run, "execute[apt-mark-hold]", :immediately
  notifies :run, "execute[apt-upgrade]", :immediately
  notifies :run, "execute[apt-cleanup]", :immediately
end

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

include_recipe "base::cachefilesd"

include_recipe "base::zsh"

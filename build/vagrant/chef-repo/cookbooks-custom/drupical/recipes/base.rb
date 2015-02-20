#
# Cookbook Name:: drupical
# Recipe:: base
#

include_recipe "apt"

execute "pin-update-cleanup" do
  command "apt-mark hold grub-pc grub-pc-bin grub2-common && apt-get update && apt-get upgrade -y && apt-get -y autoremove && apt-get -y clean"
  action :nothing
end

template "/etc/apt/apt.conf.d/90forceyes" do
  source "90forceyes"
  mode '0666'
  notifies :run, "execute[pin-update-cleanup]", :immediately
end

mount "/tmp" do
  pass     0
  fstype   "tmpfs"
  device   "/dev/null"
  options  "defaults,noatime"
  action   [:mount, :enable]
end

include_recipe "cachefilesd"

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

include_recipe "zsh"


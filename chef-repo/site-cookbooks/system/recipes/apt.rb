#
# Cookbook Name::system
# Recipe::apt
#

include_recipe "apt"

execute "apt-mark-hold" do
  command "apt-mark hold grub-pc grub-pc-bin grub2-common && apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

execute "apt-update" do
  command "apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

execute "apt-upgrade" do
  command "apt-get update && apt-get upgrade -y"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

execute "apt-cleanup" do
  command "apt-get -y autoremove && apt-get -y clean"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

template "/etc/apt/apt.conf.d/80dpkg" do
  source "80dpkg"
  mode '0666'
  notifies :run, "execute[apt-update]", :immediately
end

template "/etc/apt/apt.conf.d/90forceyes" do
  source "90forceyes"
  mode '0666'
  notifies :run, "execute[apt-mark-hold]", :immediately
  notifies :run, "execute[apt-update]", :immediately
  notifies :run, "execute[apt-upgrade]", :immediately
  notifies :run, "execute[apt-cleanup]", :immediately
end

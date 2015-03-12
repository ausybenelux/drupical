#
# Cookbook Name:: default
# Recipe:: cachefilesd
#
# Copyright 2014, CrossCheck
#
# All rights reserved - Do Not Redistribute
#
# Speeds up NFS on vagrant.
#

package "cachefilesd" do
  action :install
end

template "/etc/default/cachefilesd" do
  source "cachefilesd"
  mode 0755
end

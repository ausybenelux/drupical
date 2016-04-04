#
# Cookbook Name:: drupical
# Recipe:: database
#

include_recipe 'project::web-apt-update'
include_recipe "memcached"
include_recipe "web-memcached::php"


#
# Cookbook Name:: web-varnish
# Recipe:: varnish
#

include_recipe 'project::web-apt-update'
include_recipe "varnish"
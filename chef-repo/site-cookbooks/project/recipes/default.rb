#
# Cookbook Name:: web
# Recipe:: project
#

#
include_recipe 'project::web-apt-update'
include_recipe 'project::web-database'
include_recipe 'project::web-httpd'
include_recipe 'project::web-php5'
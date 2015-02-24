#
# Cookbook Name:: web
# Recipe:: apache
#

#
include_recipe 'web::apache'

#
include_recipe 'web-memcached::default'

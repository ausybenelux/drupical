#
# Cookbook Name:: web
# Recipe:: apache
#

#
include_recipe 'web::apache'

#
include_recipe 'web-memcached::default'

#
include_recipe 'web-solr::default'

#
include_recipe 'web-varnish::default'
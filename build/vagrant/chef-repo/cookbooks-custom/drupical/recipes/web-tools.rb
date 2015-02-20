#
# Cookbook Name:: drupical
# Recipe:: web-tools
#

Chef::Log.info('Starting drupical::web-tools')

#
include_recipe 'web-tools::adminer'

#
include_recipe 'web-tools::info'

#
include_recipe 'web-tools::opcachegui'

#
include_recipe 'web-tools::phpmemcachedadmin'


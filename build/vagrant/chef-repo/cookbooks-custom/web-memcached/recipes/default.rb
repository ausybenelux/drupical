#
# Cookbook Name:: drupical
# Recipe:: database
#

Chef::Log.info('Starting drupical::memcached')

include_recipe "memcached"
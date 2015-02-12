#
# Cookbook Name:: drupical
# Recipe:: database
#

Chef::Log.info('Starting drupical::varnish')

include_recipe "varnish"
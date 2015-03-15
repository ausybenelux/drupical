#
# Cookbook Name:: base
# Recipe:: default
#

Chef::Log.info('Starting base::default')

include_recipe "base::apt"

include_recipe "base::cachefilesd"

include_recipe "base::extra"

include_recipe "base::java"

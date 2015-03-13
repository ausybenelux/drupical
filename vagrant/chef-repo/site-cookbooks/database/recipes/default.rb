#
# Cookbook Name:: database
# Recipe:: database
#

Chef::Log.info('Starting database::default')

include_recipe "database::mysql"

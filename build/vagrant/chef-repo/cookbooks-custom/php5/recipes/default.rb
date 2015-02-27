#
# Cookbook Name:: php5
# Recipe:: default
#

node.override['php5']["version"] = node['config']['php']['php_version']

include_recipe 'php5::install'

include_recipe 'php5::packages'
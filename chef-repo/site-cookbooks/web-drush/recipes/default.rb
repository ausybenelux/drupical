#
# Cookbook Name:: web-drush
# Recipe:: drush
#

include_recipe 'project::web-apt-update'
include_recipe "web-drush::drush"

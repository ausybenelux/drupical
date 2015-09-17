#
# Cookbook Name:: web-database
# Recipe:: default
#

node.override['mysql']['server_root_password'] = node['config']['rmdbs']['root_password']
node.override['mysql']['server_debian_password'] = node['config']['rmdbs']['root_password']

#
if node['config']['rmdbs'] == 'mariadb'

  include_recipe "web-database::mariadb"

else

  include_recipe "web-database::mysql"

end

include_recipe "web-database::config"

include_recipe "web-database::site"

#include_recipe "database::backup-db"

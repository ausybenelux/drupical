#
# Cookbook Name:: database
# Recipe:: database
#

Chef::Log.info('Starting database::default')

node.override['mysql']['server_root_password'] = node['config']['rmdbs']['root_password']
node.override['mysql']['server_debian_password'] = node['config']['rmdbs']['root_password']

#
if node['config']['rmdbs'] == 'mariadb'

  include_recipe "database::mariadb"

else

  include_recipe "database::mysql"

end
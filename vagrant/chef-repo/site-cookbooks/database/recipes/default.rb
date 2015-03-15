#
# Cookbook Name:: database
# Recipe:: database
#

Chef::Log.info('Starting database::default')

#
if node['config']['rmdbs'] == 'mariadb'

  include_recipe "database::mariadb"

else

  include_recipe "database::mysql"

end
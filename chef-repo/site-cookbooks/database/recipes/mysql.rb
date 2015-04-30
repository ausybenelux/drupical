#
# Cookbook Name:: database
# Recipe::mysql
#

Chef::Log.info('Starting database::mysql')

execute "apt-update-mysql" do
  command "apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

#
include_recipe "mysql::client"

#
mysql_service 'default' do
  port '3306'
  data_dir '/var/lib/mysql'
  allow_remote_root true
  remove_anonymous_users false
  remove_test_database true
  server_root_password node['config']['rmdbs']['root_password']
  action :create
end

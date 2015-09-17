#
# Cookbook Name:: web-database
# Recipe::mysql
#

include_recipe 'web-database::mysql_repo'

directory '/var/cache/local/preseeding' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

template '/var/cache/local/preseeding/mysql-server.seed' do
  cookbook 'web-database'
  source 'mysql-server.seed.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables({:password => node['mysql']['server_root_password']})
  action :create
  notifies :run, 'execute[preseed mariadb-server]', :immediately
end

execute 'preseed mariadb-server' do
  command '/usr/bin/debconf-set-selections /var/cache/local/preseeding/mysql-server.seed'
  action :nothing
end

package 'mysql-client' do
  action :install
end

package 'mysql-server' do
  action :install
end

service 'mysql' do
  service_name 'mysql'
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
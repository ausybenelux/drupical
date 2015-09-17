#
# Cookbook Name:: web-database
# Recipe::mariadb
#

include_recipe 'database::mariadb_repo'

directory '/var/cache/local/preseeding' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

template '/var/cache/local/preseeding/mysql-server.seed' do
  cookbook 'database'
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

package 'mariadb-client' do
  action :install
end

package 'libmariadbclient-dev' do
  action :install
end

package 'mariadb-server' do
  action :install
end

service 'mysql' do
  service_name 'mysql'
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
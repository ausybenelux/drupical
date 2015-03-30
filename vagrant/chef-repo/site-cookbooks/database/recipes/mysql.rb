#
# Cookbook Name:: database
# Recipe::mysql
#

Chef::Log.info('Starting database::mysql')

node.override['mysql']['server_root_password'] = node['config']['rmdbs']['server_root_password']
node.override['mysql']['server_debian_password'] = node['config']['rmdbs']['server_root_password']

#
include_recipe "mysql::client"

#
include_recipe "mysql::server"

#
template '/etc/mysql/conf.d/mysqld_logging.cnf' do
  cookbook 'database'
  source 'mysqld-logging.cnf.erb'
  mode '0644'
end

#
template '/etc/mysql/conf.d/mysqld_max_allowed_packet.cnf' do
  cookbook 'database'
  source 'mysql-max-allowed-packet.cnf.erb'
  mode '0644'
end

#
vhosts = node['config']['vhosts']
vhosts.each do |key, vhost|

  database = vhost.fetch('database_name')
  pass = node['mysql']['server_root_password']

  bash "create-database-#{database}" do
    code <<-EOH
    mysql --user=root --password=#{pass} -e "CREATE DATABASE IF NOT EXISTS #{database}";
    EOH
  end

end
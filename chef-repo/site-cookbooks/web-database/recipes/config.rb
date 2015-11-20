#
# Cookbook Name:: web-database
# Recipe:: config
#
#

template '/etc/mysql/conf.d/mysqld_max_allowed_packet.cnf' do
  cookbook 'web-database'
  source 'mysql-max-allowed-packet.cnf.erb'
  mode '0644'
end

template '/etc/mysql/conf.d/mysqld_tweaks.cnf' do
  cookbook 'web-database'
  source 'mysql-tweaks.cnf.erb'
  mode '0644'
end

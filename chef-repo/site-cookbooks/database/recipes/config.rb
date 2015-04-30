#
template '/etc/mysql/conf.d/mysqld_logging.cnf' do
  cookbook 'database'
  source 'mysql-logging.cnf.erb'
  mode '0644'
end

#
template '/etc/mysql/conf.d/mysqld_max_allowed_packet.cnf' do
  cookbook 'database'
  source 'mysql-max-allowed-packet.cnf.erb'
  mode '0644'
end

template '/etc/mysql/conf.d/mysqld_tweaks.cnf' do
  cookbook 'database'
  source 'mysql-tweaks.cnf.erb'
  mode '0644'
end
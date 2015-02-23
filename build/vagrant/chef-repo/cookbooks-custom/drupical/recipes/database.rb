#
# Cookbook Name:: drupical
# Recipe:: database
#

Chef::Log.info('Starting drupical::database')

include_recipe "mysql::client"
include_recipe "mysql::server"

ruby_block "Ensuring mysql has the correct settings for drupal" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/mysql/my.cnf")
    fe.insert_line_after_match(/\[mysqld\]/, "max_allowed_packet = 100M")
    fe.write_file
  end
end

vhosts = node['config']['vhosts']
vhosts.each do |key, vhost|

  database = vhost.fetch('database_name')
  pass = node['mysql']['server_root_password']

  bash 'extract_module' do
    code <<-EOH
    mysql --user=root --password=#{pass} -e "CREATE DATABASE IF NOT EXISTS #{database}";
    EOH
  end

end

template "/usr/local/bin/backup-db.sh" do
  source "backup-db.sh.erb"
  mode 0777
end
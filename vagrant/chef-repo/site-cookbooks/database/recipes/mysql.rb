#
# Cookbook Name:: database
# Recipe::mysql
#

Chef::Log.info('Starting database::mysql')

#
include_recipe "mysql::client"

#
include_recipe "mysql::server"

#
ruby_block "set-mysqld-max_allowed_packet" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/mysql/my.cnf")
    fe.insert_line_after_match(/\[mysqld\]/, "max_allowed_packet = 256M")
    fe.write_file
  end
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

#
#template "/usr/local/bin/backup-db.sh" do
#  source "backup-db.sh.erb"
#  mode 0777
#end

#
# Cookbook Name:: web-database
# Recipe::site
#

#
node['config']['vhosts'].each do |key, vhost|

  database = vhost.fetch('database_name')
  pass = node['mysql']['server_root_password']

  bash "create-database-#{database}" do
    code <<-EOH
    mysql --user=root --password=#{pass} -e "CREATE DATABASE IF NOT EXISTS #{database}";
    mysql --user=root --password=#{pass} -e "GRANT ALL PRIVILEGES ON *.* TO '#{database}'@'%' IDENTIFIED BY '#{database}' WITH GRANT OPTION;";
    EOH
  end

end
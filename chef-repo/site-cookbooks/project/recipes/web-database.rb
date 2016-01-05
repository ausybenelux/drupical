#
# Cookbook Name:: web-database
# Recipe::site
#

mysql2_chef_gem 'default' do
  action :install
end

mysql_connection_info = {
    :host     => '127.0.0.1',
    :username => 'root',
    :password => node['config']['rmdbs']['root_password']
}

#
node['config']['vhosts'].each do |key, vhost|

  database = vhost.fetch('database_name')

  mysql_database "#{database}" do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user "#{database}" do
    connection mysql_connection_info
    password database
    database_name database
    host '%'
    privileges [:select, :update, :insert]
    action :grant
  end

end
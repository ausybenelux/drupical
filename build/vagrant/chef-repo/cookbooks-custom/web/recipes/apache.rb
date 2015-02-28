#
# Cookbook Name:: web
# Recipe:: apache
#

Chef::Log.info('Starting web::apache')

#
include_recipe 'web::apache_repo'

#
include_recipe 'apache2'



#
package "libapache2-mod-fastcgi" do
  action :install
end

#
execute "Enabling necessary apache2 modules" do
  command 'a2enmod actions'
  action :run
end

#
execute "Enabling necessary apache2 modules" do
  command 'a2enmod alias'
  action :run
end

#
execute "Enabling necessary apache2 modules" do
  command 'a2enmod rewrite'
  action :run
end

#
execute "Enabling necessary apache2 modules" do
  command 'a2enmod fastcgi'
  action :run
end

#
 node['config']['vhosts'].each do |key, vhost|

  web_app key do
    server_name vhost['server_name']
    server_aliases vhost['aliases']
    docroot vhost['docroot']
    allow_override 'All'
    server_pool vhost['server_name'].split('.')[0]
    cookbook 'apache2'
  end

end


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

directory "/etc/apache2/ssl" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

node['config']['vhosts'].each do |key, vhost|

  enable_ssl = false
  vhost_port = 80
  if vhost['enable_ssl'] == 'true'
    enable_ssl = true
    vhost_port = 443
   openssl_x509 "/etc/apache2/ssl/#{vhost['server_name']}.crt" do
     common_name "#{vhost['server_name']}"
     org "One Agency"
     org_unit "Web"
     country "BE"
   end
  end



  web_app key do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name vhost['server_name']
    server_aliases vhost['aliases']
    docroot vhost['docroot']
    allow_override 'All'
    enable_ssl enable_ssl
    server_port vhost_port
    server_pool vhost['server_name'].split('.')[0]
  end

end


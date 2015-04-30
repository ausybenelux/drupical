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
service 'apache2' do
  service_name 'apache2'
  supports     status: true, restart: true, reload: true
  action       [:enable, :start]
end

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

apache_module "ssl" do
  enable true
end


directory "/etc/apache2/ssl" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
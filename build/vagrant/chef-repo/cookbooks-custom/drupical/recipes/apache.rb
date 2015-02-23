#
# Cookbook Name:: drupical
# Recipe:: apache
#

Chef::Log.info('Starting drupical::apache')

#
include_recipe 'apache2'

#
execute "Enabling necessary apache2 modules" do
  command 'a2enmod actions && a2enmod alias && a2enmod rewrite && a2enmod fastcgi'
  action :run
end

#
vhosts = node['config']['vhosts']
vhosts.each do |key, vhost|

  web_app key do

    server_name vhost.fetch('server_name')
    docroot vhost.fetch('docroot')

    allow_override 'All'

    cookbook 'apache2'

  end

end


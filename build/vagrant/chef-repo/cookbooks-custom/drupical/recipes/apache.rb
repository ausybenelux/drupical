#
# Cookbook Name:: drupical
# Recipe:: apache
#

Chef::Log.info('Starting drupical::apache')

#
include_recipe 'apache2'

#
bash "Enabling mod_rewrite" do
  code <<-EOL
    a2enmod rewrite
  EOL
  notifies :restart, "service[apache2]", :delayed
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


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

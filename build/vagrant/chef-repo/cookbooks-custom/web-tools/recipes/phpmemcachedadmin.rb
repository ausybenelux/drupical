#
# Cookbook Name:: drupical
# Recipe:: phpmemcachedadmin
#

if node['config']['drupical']['web_tools']['tools']['phpmemcachedadmin']['install']

  remote_directory '/usr/share/phpmemcachedadmin' do
    source 'phpmemcachedadmin'
    mode 0777
    owner node['apache']['user']
    group node['apache']['group']
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['phpmemcachedadmin']['alias']

  web_app "phpmemcachedadmin" do
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/phpmemcachedadmin"
    cookbook 'apache2'
  end

end
#
# Cookbook Name:: drupical
# Recipe:: phpmemcachedadmin
#

if node['config']['web_tools']['tools']['phpmemcachedadmin']['install']

  remote_directory '/usr/share/phpmemcachedadmin' do
    source 'phpmemcachedadmin'
    mode 0777
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['phpmemcachedadmin']['alias']

  web_app "phpmemcachedadmin" do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/phpmemcachedadmin"
    cookbook 'apache2'
    server_pool "phpmemcachedadmin"
  end

  php_fpm_pool "phpmemcachedadmin" do
    process_manager "dynamic"
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    max_requests 5000
  end

end
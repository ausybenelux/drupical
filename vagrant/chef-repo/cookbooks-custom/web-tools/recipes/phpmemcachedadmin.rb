if node['config']['web_tools']['phpmemcachedadmin']['phpmemcachedadmin_install']

  remote_directory '/usr/share/phpmemcachedadmin' do
    source 'phpmemcachedadmin'
    mode 0777
    owner node['apache']['user']
    group node['apache']['group']
  end

  web_app "phpmemcachedadmin" do
    server_name node['config']['web_tools']['phpmemcachedadmin']['phpmemcachedadmin_alias']
    docroot "/usr/share/phpmemcachedadmin"
    cookbook 'apache2'
  end

end
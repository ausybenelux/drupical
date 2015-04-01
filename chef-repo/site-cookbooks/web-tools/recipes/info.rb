#
# Cookbook Name:: drupical
# Recipe:: info
#
if node['config']['web_tools']['tools']['info']['install']

  remote_directory '/usr/share/siteinfo' do
    source 'info'
    mode 0777
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  template "/usr/share/siteinfo/index.php" do
    source "info_index.php.erb"
    mode '0666'
  end

  template "/usr/share/siteinfo/phpinfo.php" do
    source "info_phpinfo.php.erb"
    mode '0666'
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['info']['alias']

  web_app "info" do
    templates 'web_app.conf.erb'
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/siteinfo/"
    cookbook 'apache2'
    server_pool "info"
  end

  php_fpm_pool "info" do
    process_manager "dynamic"
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    max_requests 5000
  end

end
#
# Cookbook Name:: drupical
# Recipe:: info
#

if node['config']['drupical']['web_tools']['tools']['info']['install']

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

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['info']['alias']

  web_app "info" do
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/siteinfo/"
    cookbook 'apache2'
    server_pool "info"
  end

end
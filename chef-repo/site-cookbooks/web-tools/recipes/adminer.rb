#
# Cookbook Name:: drupical
# Recipe:: adminer
#

if node['config']['web_tools']['tools']['adminer']['install']

  directory '/usr/share/adminer' do
    mode 0777
    action :create
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  remote_file "/usr/share/adminer/adminer.php" do
    source "http://downloads.sourceforge.net/project/adminer/Adminer/Adminer%204.2.0/adminer-4.2.0-mysql-en.php"
    mode 0777
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  template "/usr/share/adminer/index.php" do
    source "adminer_index.php.erb"
    mode 0777
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  template "/usr/share/adminer/.htaccess" do
    source "htaccess-no-errors"
    mode 0777
    #owner node['apache']['user']
    #group node['apache']['group']
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['adminer']['alias']

  web_app "adminer" do
    server_name "#{tool_alias}.#{url_base}"
    allow_override "All"
    docroot "/usr/share/adminer/"
    server_pool "adminer"
    templates 'web_app.conf.erb'
    cookbook 'apache2'
  end

  php_fpm_pool "adminer" do
    process_manager "dynamic"
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    max_requests 5000
  end

end
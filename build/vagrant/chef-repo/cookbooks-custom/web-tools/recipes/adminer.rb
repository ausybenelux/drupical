#
# Cookbook Name:: drupical
# Recipe:: adminer
#

if node['config']['drupical']['web_tools']['tools']['adminer']['install']

  directory '/usr/share/adminer' do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  remote_file "/usr/share/adminer/adminer.php" do
    source "http://downloads.sourceforge.net/project/adminer/Adminer/Adminer%204.2.0/adminer-4.2.0-mysql-en.php"
    mode 0777
    owner node['apache']['user']
    group node['apache']['group']
  end

  template "/usr/share/adminer/index.php" do
    source "index_adminer.php.erb"
    mode 0777
    owner node['apache']['user']
    group node['apache']['group']
  end

  template "/usr/share/adminer/.htaccess" do
    source "htaccess-no-errors"
    mode 0777
    owner node['apache']['user']
    group node['apache']['group']
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['adminer']['alias']

  web_app "adminer" do
    server_name "#{tool_alias}.#{url_base}"
    allow_override "All"
    docroot "/usr/share/adminer/"
    cookbook 'apache2'
  end

end
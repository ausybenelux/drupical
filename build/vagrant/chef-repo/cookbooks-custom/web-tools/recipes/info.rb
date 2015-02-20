#
# Cookbook Name:: drupical
# Recipe:: info
#

if node['config']['drupical']['web_tools']['tools']['info']['install']

  directory '/usr/share/info' do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  template "/usr/share/info/index.php" do
    source "info.php.erb"
    mode '0666'
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['info']['alias']

  web_app "itworks" do
    server_name "#{url_base}.#{tool_alias}"
    docroot "/usr/share/info/"
    cookbook 'apache2'
  end

end
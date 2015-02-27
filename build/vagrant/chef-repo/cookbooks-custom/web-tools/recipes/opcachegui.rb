#
# Cookbook Name:: drupical
# Recipe:: opcachegui
#

if node['config']['web_tools']['tools']['opcachegui']['install']

  directory "/usr/share/opcachegui" do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  if node["php5"]["version"] == "5.3" || node["php5"]["version"] == "5.4"

    link "/usr/share/opcachegui/index.php" do
      to "/usr/share/doc/php-apc/apc.php"
    end

  elsif node["php5"]["version"] == "5.5"

    git "/usr/share/opcachegui" do
      repository "https://github.com/PeeHaa/OpCacheGUI.git"
      action :sync
    end

    file "/usr/share/opcachegui/init.deployment.php" do
      action :delete
      only_if { File.exists?("/usr/share/opcachegui/init.deployment.php") }
    end

    cookbook_file "/usr/share/opcachegui/init.deployment.php" do
      source "opcachegui_init.deployment.php"
      mode 0777
      action :create
      owner node['apache']['user']
      group node['apache']['group']
    end

  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['opcachegui']['alias']

  web_app "opcachegui" do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/opcachegui/"
    server_pool "opcachegui"
  end

end
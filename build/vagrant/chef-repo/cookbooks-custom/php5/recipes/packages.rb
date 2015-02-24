#
# Cookbook Name:: php5
# Recipe:: packages
#

#
package "php5-mysqlnd" do
  action :install
end

#
if node['config']['drupical']['php']['enable_php_gd']

  package "php5-gd" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_opcode_cache']

  if node["php5"]["version"] == "5.3" && node["php5"]["version"] == "5.4"
    package "php-apc" do
      action :install
    end
  end

end

#
if node['config']['drupical']['php']['enable_php_curl']

  include_recipe "curl"

  package "php5-curl" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_memcache']

  include_recipe 'memcached'

  package "php5-memcached" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_mcrypt']

  package "php5-mcrypt" do
    action :install
  end

end

if node['config']['drupical']['php']['enable_php_phing']

  include_recipe 'phing'

end

#
if node['config']['drupical']['php']['enable_php_composer']

  include_recipe "composer"

end

if node['config']['drupical']['php']['enable_php_xdebug']

  package "php5-xdebug" do
    options " || true"
    action :install
  end

  file "/etc/php5/mods-available/xdebug.ini" do
    action :delete
    only_if { File.exists?("/etc/php5/mods-available/xdebug.ini") }
  end

  template "/etc/php5/mods-available/xdebug.ini" do
    source "xdebug.ini"
    mode 0644
    owner "root"
    group "root"
    action :create
  end

  link "/etc/php5/fpm/conf.d/xdebug.ini" do
    to "/etc/php5/mods-available/xdebug.ini"
    notifies :restart, 'service[apache2]', :delayed
  end

end

#
if node['config']['drupical']['php']['enable_php_uprofiler']

  package "php5-uprofiler" do
    action :install
  end

  file "/etc/php5/mods-available/uprofiler.ini" do
    action :delete
    only_if { File.exists?("/etc/php5/mods-available/uprofiler.ini") }
  end

  template "/etc/php5/mods-available/uprofiler.ini" do
    source "uprofiler.ini"
    mode 0644
    owner "root"
    group "root"
    action :create
    notifies :restart, 'service[apache2]', :delayed
  end

end
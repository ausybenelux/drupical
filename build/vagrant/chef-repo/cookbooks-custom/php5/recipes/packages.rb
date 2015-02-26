#
# Cookbook Name:: php5
# Recipe:: packages
#

node['config']['php_packages'].each do |php_package, install_php_package|

  if install_php_package

    puts php_package

    package php_package do
      action :install
    end

  end

end

#
if node['config']['drupical']['php']['enable_php_phing']

  include_recipe 'phing'

end

#
if node['config']['drupical']['php']['enable_php_composer']

  include_recipe "composer"

end

#
if node['config']['php_packages']['php5-xdebug']

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
    only_if { File.directory?("/etc/php5/fpm/conf.d/") }
    notifies :restart, 'service[apache2]', :delayed
  end

end

#
if node['config']['php_packages']['php5-uprofiler']

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
    only_if { !File.exists?("/etc/php5/mods-available/uprofiler.ini") }
  end

end
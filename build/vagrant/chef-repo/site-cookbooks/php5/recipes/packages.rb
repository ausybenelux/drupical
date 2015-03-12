#
# Cookbook Name:: php5
# Recipe:: packages
#

#
#if node['config']['php']['enable_php_phing']

#  include_recipe 'phing'

#end

#
if node['config']['php']['enable_php_composer']

  include_recipe "composer"

end



#
node['config']['php_packages'].each do |php_package, install_php_package|

  if install_php_package

    package php_package do
      action :install
      notifies :reload, 'service[php-fpm]', :delayed
    end

  end

end

#
if node['config']['php_packages']['php5-xdebug']

  if node['config']['php']['php_version'] == '5.3'

    file "/etc/php5/conf.d/xdebug.ini" do
      action :delete
    end

    template "/etc/php5/conf.d/xdebug.ini" do
      source "20090626-xdebug.ini"
      mode 0644
      owner "root"
      group "root"
      action :create
    end

  else

    file "/etc/php5/mods-available/xdebug.ini" do
      action :delete
    end
    
    file "/etc/php5/mods-available/20-xdebug.ini" do
      action :delete
    end

    template "/etc/php5/mods-available/20-xdebug.ini" do
      source "20100525-xdebug.ini"
      mode 0644
      owner "root"
      group "root"
      action :create
    end
  
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
    notifies :reload, 'service[php-fpm]', :delayed
    only_if { !File.exists?("/etc/php5/mods-available/uprofiler.ini") }
  end

end
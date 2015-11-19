#
# Cookbook Name::web-php5
# Recipe::packages
#

#
if node['config']['php']['enable_php_phing']

  bash "install-phing" do
    code <<-EOH
    (wget http://www.phing.info/get/phing-latest.phar)
    (chmod +x phing-latest.phar)
    (sudo mv phing-latest.phar /usr/local/bin/phing)
    EOH
  end

end

#
if node['config']['php']['enable_php_composer']

  include_recipe "composer"

end

#
node['config']['php_packages'].each do |php_package, install_php_package|

  if install_php_package
    package php_package do
      action :install
    end
  end

end

#
if node['config']['php_packages']['php5-xdebug']

  file "/etc/php5/mods-available/xdebug.ini" do
    action :delete
    only_if { ::File.exists?("/etc/php5/mods-available/xdebug.ini")}
  end

  file "/etc/php5/mods-available/20-xdebug.ini" do
    action :delete
    only_if { ::File.exists?("/etc/php5/mods-available/20-xdebug.ini")}
  end

  template "/etc/php5/mods-available/xdebug.ini" do
    source "20100525-xdebug.ini"
    mode 0644
    owner "root"
    group "root"
    action :create
    only_if { ::File.exists?("/etc/php5/mods-available/")}
  end

  execute "xdebug" do
    command 'php5enmod xdebug'
    action :run
    only_if { ::File.exists?("/etc/php5/mods-available/")}
  end

  file "/etc/php5/conf.d/xdebug.ini" do
    action :delete
    only_if { ::File.exists?("/etc/php5/conf.d/xdebug.ini")}
  end

  template "/etc/php5/conf.d/xdebug.ini" do
    source "20090626-xdebug.ini"
    mode 0644
    owner "root"
    group "root"
    action :create
    only_if { ::File.exists?("/etc/php5/conf.d/")}
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

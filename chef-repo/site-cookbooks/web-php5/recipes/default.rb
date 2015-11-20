#
# Cookbook Name::web-php5
# Recipe:: web-php5
#

#
include_recipe 'php'

#
package "libapache2-mod-php5" do
  action :install
end

include_recipe 'apache2::mod_php5'
include_recipe 'web-php5::packages'

file "/etc/php5/mods-available/php-tweaks.ini" do
  action :delete
  only_if { ::File.exists?("/etc/php5/mods-available/")}
end

template "/etc/php5/mods-available/php-tweaks.ini" do
  source "php.tweaks.ini"
  mode 0644
  owner "root"
  group "root"
  action :create
  only_if { ::File.exists?("/etc/php5/mods-available/")}
end

execute "tweak php" do
  command 'php5enmod php.tweaks'
  action :run
  only_if { ::File.exists?("/etc/php5/mods-available/")}
end

template "/etc/php5/conf.d/php-tweaks.ini" do
  source "php.tweaks.ini"
  mode 0644
  owner "root"
  group "root"
  action :create
  only_if { ::File.exists?("/etc/php5/conf.d/")}
end
#
# Cookbook Name::web-php5
# Recipe:: web-php5_54
#

#
node.override['config']['php']['php_version'] = '5.4'

#
include_recipe 'web-php5::php5_54_repo'

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
end

template "/etc/php5/mods-available/php-tweaks.ini" do
  source "php.tweaks.ini"
  mode 0644
  owner "root"
  group "root"
  action :create
end

execute "tweak php" do
  command 'php5enmod php.tweaks'
  action :run
end

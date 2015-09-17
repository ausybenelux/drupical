#
# Cookbook Name:: web-php5
# Recipe:: default
#

execute "apt-update-php5" do
  command "apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

node.override['php5']["version"] = node['config']['php']['php_version']

if node["php5"]["version"] == "5.3"

  #
  include_recipe 'php5::php5_53'

elsif node["php5"]["version"] == "5.4"

  #
  include_recipe 'php5::php5_54'

elsif node["php5"]["version"] == "5.5"

  #
  include_recipe 'php5::php5_55'

elsif node["php5"]["version"] == "5.6"

  #
  include_recipe 'php5::php5_56'

end

#
#We have to disable apache2::mod_php5 because it'll interfere with the PHP-FPM module.
#
#include_recipe 'apache2::mod_php5'

include_recipe 'web-php5::php_fpm'
include_recipe 'web-php5::packages'



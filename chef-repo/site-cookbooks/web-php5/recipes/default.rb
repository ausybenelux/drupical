#
# Cookbook Name:: web-php5
# Recipe:: default
#

node['php']['version'] = node['config']['php']['php_version']

if node["php5"]["version"] == "5.3"
  include_recipe 'php5::php5_53'
elsif node["php5"]["version"] == "5.4"
  include_recipe 'php5::php5_54'
elsif node["php5"]["version"] == "5.5"
  include_recipe 'php5::php5_55'
elsif node["php5"]["version"] == "5.6"
  include_recipe 'php5::php5_56'
end

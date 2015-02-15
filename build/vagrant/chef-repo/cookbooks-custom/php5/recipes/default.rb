#
# Cookbook Name:: php5
# Recipe:: default
#

node.override['php5']["version"] = node['config']['drupical']['php']['php_version']

Chef::Log.info('Installing php version ' + node["php5"]["version"])

if node["php5"]["version"] == "5.3"

elsif node["php5"]["version"] == "5.4"

  #
  include_recipe 'php5::php5_54_ppa'

elsif node["php5"]["version"] == "5.5"

  #
  include_recipe 'php5::php5_55_ppa'

end

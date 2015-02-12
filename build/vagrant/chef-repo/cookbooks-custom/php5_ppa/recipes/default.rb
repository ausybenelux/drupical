#
# Cookbook Name:: php5_ppa
# Recipe:: default
#

node.override['php5_ppa']["version"] = node['config']['drupical']['php']['php_version']

Chef::Log.info('Installing php version ' + node["php5_ppa"]["version"])

node.override['php']['packages'] = %w{ php5 php5-dev php-pear }

if node["php5_ppa"]["version"] == "5.3"

  include_recipe 'php5_ppa::from_skettler'

elsif node["php5_ppa"]["version"] == "5.4"

  include_recipe 'php5_ppa::from_ondrej_old'

elsif node["php5_ppa"]["version"] == "5.5"

  include_recipe 'php5_ppa::from_ondrej'

end
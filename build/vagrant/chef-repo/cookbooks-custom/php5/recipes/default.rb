#
# Cookbook Name:: php5
# Recipe:: default
#

node.override['php5']["version"] = node['config']['drupical']['php']['php_version']

Chef::Log.info('Installing php version ' + node["php5"]["version"])

node.override['php']['packages'] = %w{ php5 php5-dev php-pear }

if node["php5"]["version"] == "5.3"

  include_recipe 'php5::php5_53_ppa'

elsif node["php5"]["version"] == "5.4"

  include_recipe 'php5::php5_54_ppa'

elsif node["php5"]["version"] == "5.5"

  include_recipe 'php5::php5_54_ppa'

elsif node["php5"]["version"] == "5.6"

  include_recipe 'php5::php5_56_dotdeb'

end
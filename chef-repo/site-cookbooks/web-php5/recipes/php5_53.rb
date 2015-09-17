#
# Cookbook Name::web-php5
# Recipe:: web-php5_53
#

#
node.override['config']['php']['php_version'] = '5.3'

include_recipe 'php'
include_recipe 'web-php5::php_fpm'

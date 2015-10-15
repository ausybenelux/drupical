#
# Cookbook Name::web-php5
# Recipe:: web-php5_55
#

#
node.override['config']['php']['php_version'] = '5.5'

#
include_recipe 'web-php5::php5_55_repo'

#
include_recipe 'php'
include_recipe 'web-php5::php_fpm'
include_recipe 'web-php5::packages'

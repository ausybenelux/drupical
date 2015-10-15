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
include_recipe 'web-php5::php_fpm'
include_recipe 'web-php5::packages'

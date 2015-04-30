
#
node.override['config']['php']['php_version'] = '5.4'

#
include_recipe 'php5::php5_54_repo'

#
include_recipe 'php'

#
include_recipe 'php-fpm'

#
node.override['config']['php']['php_version'] = '5.5'

#
include_recipe 'php5::php5_55_repo'

#
include_recipe 'php'

#
include_recipe 'php-fpm'
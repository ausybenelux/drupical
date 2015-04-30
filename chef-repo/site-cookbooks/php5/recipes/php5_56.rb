
#
node.override['config']['php']['php_version'] = '5.6'

#
include_recipe 'php5::php5_56_repo'

#
include_recipe 'php'

#
include_recipe 'php-fpm'
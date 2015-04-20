
#
node.override['config']['php']['php_version'] = '5.3'

include_recipe 'php'

#
include_recipe 'php-fpm'
#
# Cookbook Name:: web-drush
# Recipe:: drush
#

if node['config']['php']['enable_php_drush']

  include_recipe "web-drush::drush"

end

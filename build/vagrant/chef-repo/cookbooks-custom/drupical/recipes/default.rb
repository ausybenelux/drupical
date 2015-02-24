#
if node['config']['drupical']['php']['enable_php_drush']

  include_recipe "drupical::drush"

end
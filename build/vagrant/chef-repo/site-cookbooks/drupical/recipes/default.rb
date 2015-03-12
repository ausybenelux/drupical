#
if node['config']['php']['enable_php_drush']

  include_recipe "drupical::drush"

end
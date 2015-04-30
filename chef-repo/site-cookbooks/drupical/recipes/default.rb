#
if node['config']['php']['enable_php_drush']

  include_recipe "drupical::drush"

end

include_recipe "drupical::site"

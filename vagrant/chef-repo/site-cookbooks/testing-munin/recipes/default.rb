#
# Cookbook Name::testing-munin
# Recipe::munin
#

if node['config']['web_tools']['tools']['munin']['install']

  include_recipe 'testing-munin::munin_repo'
  
  include_recipe 'testing-munin::munin_install'

end
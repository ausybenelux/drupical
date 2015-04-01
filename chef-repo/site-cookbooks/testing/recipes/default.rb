#
# Cookbook Name::testing
# Recipe::default
#
if node['config']['testing']['testing_install']

	if node['config']['testing']['munin']['install']
		include_recipe 'testing-munin::default'
	end

	if node['config']['testing']['selenium']['install']
		include_recipe 'testing-selenium::default'
	end

	include_recipe 'testing-phpunit::default'

end
#
# Cookbook Name:: testing-phpunit
# Recipe:: default
#

Chef::Log.info('Starting testing-phpunit::default')

bash "upgrade-pear" do
  code <<-EOH
	(sudo pear upgrade pear)
  	(sudo pear clear-cache)
	(sudo pear update-channels)
  EOH
end

php_pear_channel "pear.symfony-project.com" do
  action :discover
end

php_pear_channel "components.ez.no" do
  action :discover
end

php_pear "PHPUnit2" do
  action :install
  options '--alldeps'
end

php_pear "Testing_Selenium" do
  action :install
  options '--alldeps'
  preferred_state 'alpha'
end

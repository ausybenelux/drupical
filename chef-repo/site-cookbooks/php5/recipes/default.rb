#
# Cookbook Name:: php5
# Recipe:: default
#

execute "apt-update-php5" do
  command "apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

node.override['php5']["version"] = node['config']['php']['php_version']

include_recipe 'php5::install'


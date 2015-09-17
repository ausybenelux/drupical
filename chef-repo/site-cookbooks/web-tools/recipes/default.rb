#
# Cookbook Name:: drupical
# Recipe:: web-tools
#

execute "apt-update-webtools" do
  command "apt-get update"
  action :nothing
  ignore_failure true
  only_if { apt_installed? }
end

include_recipe 'php-fpm'

#
include_recipe 'web-tools::info'

#
include_recipe 'web-tools::adminer'

#
include_recipe 'web-tools::opcachegui'

#
include_recipe 'web-tools::phpmemcachedadmin'

#
include_recipe 'web-tools::profiler'

#
include_recipe 'web-tools::phpdoc'

#
include_recipe 'web-tools::mailcatcher'
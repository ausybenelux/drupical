#
# Cookbook Name:: drupical
# Recipe:: php
#

Chef::Log.info('Starting drupical::php')

#
include_recipe 'php5_ppa::default'

#
include_recipe 'apache2::mod_php5'

#
include_recipe 'php'

#
package "php5-mysqlnd" do
  action :install
end

#
package "php5-gd" do
  action :install
end

#
if node['config']['drupical']['php']['enable_php_apc']

  package "php-apc" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_curl']

  include_recipe "curl"

  package "php5-curl" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_memcache']

  include_recipe 'memcached'

  package "php5-memcache" do
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_xdebug']

  package "php5-xdebug" do
    options "--no-install-recommends --quiet --assume-yes"
    action :install
  end

end

#
if node['config']['drupical']['php']['enable_php_phing']

  include_recipe 'phing'

end

#
if node['config']['drupical']['php']['enable_php_drush']

  include_recipe "drush::default"
  include_recipe "drush::aliases"

end

#
if node['config']['drupical']['php']['enable_php_composer']

  include_recipe "composer"

end

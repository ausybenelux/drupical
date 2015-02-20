#
# Cookbook Name:: drupical
# Recipe:: php
#

Chef::Log.info('Starting drupical::php')


include_recipe 'php-fpm'

#
#Installing the default pool
#With the correct PHP settings for drupal installations
#
php_fpm_pool "www" do
  process_manager "dynamic"
  max_requests 5000
  php_options 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '512M', 'php_admin_value[error_reporting]' =>  'E_ALL & ~E_DEPRECATED', 'php_admin_value[display_errors]'  =>  'On', 'php_admin_value[post_max_size]'  =>  '64M', 'php_admin_value[upload_max_filesize]' =>  '64M'
end

#
include_recipe 'php5::default'

#
include_recipe 'php'

#
#We have to disable apache2::mod_php5 because it'll interfere with the PHP-FPM module.
#
#include_recipe 'apache2::mod_php5'

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
  if node["php5"]["version"] != "5.5" && node["php5"]["version"] != "5.6"
    package "php-apc" do
      action :install
    end
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


if node['config']['drupical']['php']['enable_php_xdebug']

  package "php5-xdebug" do
    options " || true"
    action :install
  end

  # template "/etc/php5/conf.d/xdebug.ini" do
  #   source "xdebug.ini"
  #   mode 0644
  #   owner "root"
  #   group "root"
  #   action :create
  # end

  #link "/etc/php5/conf.d/xdebug.ini" do
  #  to "/etc/php5/mods-available/xdebug.ini"
  #end

end


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


file '/etc/apache2/conf-available/php-fpm.conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/apache2/conf-available/php-fpm.conf' do
  source 'php-fpm.conf'
  mode '0644'
  notifies :restart, 'service[apache2]', :delayed
  not_if {!File.exists?('/etc/apache2/conf-available/php-fpm.conf')}
end

link '/etc/apache2/conf-enabled/php-fpm.conf' do
  to '/etc/apache2/conf-available/php-fpm.conf'
end
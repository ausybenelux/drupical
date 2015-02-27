#
# Cookbook Name:: php5
# Recipe:: install
#

if node["php5"]["version"] == "5.3"

elsif node["php5"]["version"] == "5.4"

  #
  include_recipe 'php5::php5_54_ppa'

elsif node["php5"]["version"] == "5.5"

  #
  include_recipe 'php5::php5_55_ppa'

end

#
include_recipe 'php-fpm'

#
include_recipe 'php'

#
#We have to disable apache2::mod_php5 because it'll interfere with the PHP-FPM module.
#
#include_recipe 'apache2::mod_php5'

#
php_fpm_pool "www" do
  process_manager "dynamic"
  max_requests 5000
  php_options 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '512M', 'php_admin_value[error_reporting]' =>  'E_ALL & ~E_DEPRECATED', 'php_admin_value[display_errors]'  =>  'On', 'php_admin_value[post_max_size]'  =>  '64M', 'php_admin_value[upload_max_filesize]' =>  '64M'
end

file "/etc/apache2/conf-available/php-fpm.conf" do
  action :delete
  only_if { File.exists?("/etc/apache2/conf-available/php-fpm.conf") }
end

template '/etc/apache2/conf-available/php-fpm.conf' do
  source 'php-fpm.conf'
  mode '0644'
  notifies :restart, 'service[apache2]', :delayed
  only_if {!File.exists?('/etc/apache2/conf-available/php-fpm.conf')}
end

link '/etc/apache2/conf-enabled/php-fpm.conf' do
  to '/etc/apache2/conf-available/php-fpm.conf'
  not_if { File.symlink?("/etc/apache2/conf-enabled/php-fpm.conf") }
end
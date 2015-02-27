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
node['config']['vhosts'].each do |key, vhost|

  php_settings = {}
  vhost['php_settings'].each do |setting_key, value|
    php_settings[setting_key] = value
  end

  php_fpm_pool vhost['server_name'].split('.')[0] do
    process_manager "dynamic"
    max_requests 5000
    php_options php_settings
  end

end

#
node['config']['web_tools']['tools'].each do |key, tool|
  if tool['install'] == true
    php_fpm_pool key do
      process_manager "dynamic"
      max_requests 5000
    end
  end
end

file "/etc/apache2/conf-available/php-fpm.conf" do
  action :delete
  only_if { File.exists?("/etc/apache2/conf-available/php-fpm.conf") }
end

template '/etc/apache2/conf-available/php-fpm.conf' do
  source 'php-fpm.conf'
  mode '0644'
  notifies :restart, 'service[apache2]', :delayed
end

link '/etc/apache2/conf-enabled/php-fpm.conf' do
  to '/etc/apache2/conf-available/php-fpm.conf'
  not_if { File.symlink?("/etc/apache2/conf-enabled/php-fpm.conf") }
end
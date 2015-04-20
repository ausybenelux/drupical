include_recipe 'php-fpm'

#
node['config']['vhosts'].each do |key, vhost|

  php_settings = {}
  vhost['php_settings'].each do |setting_key, value|
    php_settings["php_admin_value[#{setting_key}]"] = value
  end

  php_fpm_pool vhost['server_name'].split('.')[0] do
    process_manager "dynamic"
    max_requests 5000
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    php_options php_settings
  end

  if vhost['enable_ssl'] == 'true'

    php_fpm_pool "#{vhost['server_name'].split('.')[0]}-ssl" do
      process_manager "dynamic"
      max_requests 5000
      max_children 10
      min_spare_servers 2
      max_spare_servers 5
      php_options php_settings
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
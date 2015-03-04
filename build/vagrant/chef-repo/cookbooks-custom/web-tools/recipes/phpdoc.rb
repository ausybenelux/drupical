#
# Cookbook Name:: drupical
# Recipe:: phpdoc
#

if node['config']['web_tools']['tools']['phpdoc']['install']

  package "php-doc" do
    action :install
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['phpdoc']['alias']

  web_app "phpdoc" do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/doc/php-doc/html/"
    cookbook 'apache2'
    server_pool "phpdoc"
  end

  php_fpm_pool "phpdoc" do
    process_manager "dynamic"
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    max_requests 5000
  end

end
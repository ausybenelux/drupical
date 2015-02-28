#
# Cookbook Name:: drupical
# Recipe:: phpdoc
#

if node['config']['drupical']['web_tools']['tools']['phpdoc']['install']

  package "php-doc" do
    action :install
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['phpdoc']['alias']

  web_app "phpdoc" do
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/doc/php-doc/html/"
    cookbook 'apache2'
    server_pool "tools"
  end

end
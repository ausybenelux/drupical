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
<<<<<<< HEAD
    cookbook 'apache2'
    server_pool "tools"
=======
    server_pool "phpdoc"
>>>>>>> b66a0a1934a3660b5977807e16a441c209a27034
  end

end
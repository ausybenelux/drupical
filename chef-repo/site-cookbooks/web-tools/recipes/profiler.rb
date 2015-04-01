#
# Cookbook Name:: drupical
# Recipe:: profiler
#

if node['config']['web_tools']['tools']['uprofiler_ui']['install']

  package "uprofiler-ui" do
    action :install
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['uprofiler_ui']['alias']

  web_app "uprofiler" do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/uprofiler/uprofiler_html"
    cookbook 'apache2'
    server_pool "uprofiler"
  end

  php_fpm_pool "uprofiler" do
    process_manager "dynamic"
    max_children 10
    min_spare_servers 2
    max_spare_servers 5
    max_requests 5000
  end

end
#
# Cookbook Name:: drupical
# Recipe:: profiler
#

if node['config']['drupical']['web_tools']['tools']['uprofiler_ui']['install']

  package "uprofiler-ui" do
    action :install
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['uprofiler_ui']['alias']

  web_app "uprofiler" do
    server_name "#{tool_alias}.#{url_base}"
    docroot "/usr/share/uprofiler/uprofiler_html"
    cookbook 'apache2'
    server_pool "tools"
  end

end
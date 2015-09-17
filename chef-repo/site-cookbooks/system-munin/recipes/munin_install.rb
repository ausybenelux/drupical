#
# Cookbook Name::testing-munin
# Recipe::install
#

package "munin" do
  action :install
end

git "/etc/munin/template_munstrap" do
  repository "https://github.com/jonnymccullagh/munstrap.git"
  action :sync
end

template "/etc/munin/munin-conf.d/munin-folders" do
  source "munin-folders"
  mode 0777
end

url_base = node['config']['web_tools']['url_base']
tool_alias = node['config']['web_tools']['tools']['munin']['alias']

web_app "munin" do
  server_name "#{tool_alias}.#{url_base}"
  docroot "/var/cache/munin/www"
  cookbook 'apache2'
  allow_override 'All'
end

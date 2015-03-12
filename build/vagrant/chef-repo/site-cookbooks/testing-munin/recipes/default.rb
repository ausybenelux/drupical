#
# Cookbook Name:: testing-munin
# Recipe::munin
#

if node['config']['web_tools']['tools']['munin']['install']

	package "munin" do
		action :install
	end

	template "/etc/munin/munin-conf.d/munin-folders" do
		source "munin-folders"
		mode 0777
	end

	git "/opt/munin-monitoring" do
		repository "https://github.com/munin-monitoring/contrib.git"
		action :sync
		notifies :run, "execute[move-templates]", :immediately
	end

	execute "move-templates" do
		command <<-EOH
		  (mv /etc/munin/templates /etc/munin/factory)
		  (mkdir /etc/munin/templates)
		  (mkdir /etc/munin/templates/munstrap)
		  (mv /etc/munin/factory /etc/munin/templates)
		  (cp -avr /opt/munin-monitoring/templates/munstrap/templates/. /etc/munin/templates/munstrap)
		  (cp -avr /opt/munin-monitoring/templates/munstrap/static/. /etc/munin/templates/munstrap)
		EOH
 		action :nothing
	end

	url_base = node['config']['web_tools']['url_base']
	tool_alias = node['config']['web_tools']['tools']['munin']['alias']

	web_app "munin" do
		server_name "#{tool_alias}.#{url_base}"
		docroot "/var/cache/munin/www"
		cookbook 'apache2'
		allow_override 'All'
	end

end
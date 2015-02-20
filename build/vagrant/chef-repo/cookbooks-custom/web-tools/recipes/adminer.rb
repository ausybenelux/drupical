#
# Cookbook Name:: drupical
# Recipe:: adminer
#

if node['config']['drupical']['web_tools']['tools']['adminer']['install']

  git "/usr/share/adminer" do
    repository "https://github.com/vrana/adminer.git"
    reference "v4.2.0"
    action :sync
  end

  url_base = node['config']['drupical']['web_tools']['url_base']
  tool_alias = node['config']['drupical']['web_tools']['tools']['adminer']['alias']

  web_app "adminer" do
    server_name "#{url_base}.#{tool_alias}"
    docroot "/usr/share/adminer/adminer"
    cookbook 'apache2'
  end

end
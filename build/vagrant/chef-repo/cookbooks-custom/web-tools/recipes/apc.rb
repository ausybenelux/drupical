if node['config']['drupical']['web_tools']['apc']['apc_install']

  directory "/usr/share/apc" do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  link "/usr/share/apc/index.php" do
    to "/usr/share/doc/php-apc/apc.php"
  end

  web_app "apc" do
    server_name node['config']['drupical']['web_tools']['apc']['apc_alias']
    docroot "/usr/share/apc"
    cookbook 'apache2'
  end

end
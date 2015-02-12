if node['config']['drupical']['web_tools']['adminer']['adminer_install']

  directory "/usr/share/adminer" do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  cookbook_file "/usr/share/adminer/adminer.php" do
    source "adminer.php"
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  link "/usr/share/adminer/index.php" do
    to "/usr/share/adminer/adminer.php"
  end

  web_app "adminer" do
    server_name node['config']['drupical']['web_tools']['adminer']['adminer_alias']
    docroot "/usr/share/adminer"
    cookbook 'apache2'
  end

end

if node['config']['drupical']['web_tools']['itworks']['itworks_install']

  directory '/usr/share/itworks' do
    mode 0777
    action :create
    owner node['apache']['user']
    group node['apache']['group']
  end

  template "/usr/share/itworks/index.php" do
    source "it-works.php.erb"
    mode '0666'
  end

  web_app "itworks" do
    server_name node['config']['drupical']['web_tools']['itworks']['itworks_alias']
    docroot "/usr/share/itworks/"
    cookbook 'apache2'
  end

end
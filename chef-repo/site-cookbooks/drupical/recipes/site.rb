#
node['config']['vhosts'].each do |key, vhost|

  database = vhost.fetch('database_name')
  pass = node['mysql']['server_root_password']

  bash "create-database-#{database}" do
    code <<-EOH
    mysql --user=root --password=#{pass} -e "CREATE DATABASE IF NOT EXISTS #{database}";
    mysql --user=root --password=#{pass} -e "GRANT ALL PRIVILEGES ON *.* TO '#{database}'@'%' IDENTIFIED BY '#{database}' WITH GRANT OPTION;";
    EOH
  end

end

include_recipe 'php5::php_fpm'

#
node['config']['vhosts'].each do |key, vhost|

  if vhost['enable_ssl'] == 'true'

    openssl_x509 "/etc/apache2/ssl/#{vhost['server_name']}.crt" do
      common_name "#{vhost['server_name']}"
      org "One Agency"
      org_unit "Web"
      country "BE"
    end

    web_app "#{key}-ssl" do
      templates 'web_app.conf.erb'
      cookbook 'web'
      server_name vhost['server_name']
      server_aliases vhost['aliases']
      docroot vhost['docroot']
      allow_override 'All'
      enable_ssl 'true'
      server_port 443
      server_pool "#{vhost['server_name'].split('.')[0]}-ssl"
    end

  end

  web_app key do
    templates 'web_app.conf.erb'
    cookbook 'web'
    server_name vhost['server_name']
    server_aliases vhost['aliases']
    docroot vhost['docroot']
    allow_override 'All'
    enable_ssl 'false'
    server_port 80
    server_pool vhost['server_name'].split('.')[0]
  end

end

include_recipe 'php5::packages'
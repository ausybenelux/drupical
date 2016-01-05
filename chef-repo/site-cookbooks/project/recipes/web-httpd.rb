#
# Cookbook Name:: web-httpd
# Recipe::site
#

#
node['config']['vhosts'].each do |key, vhost|

  web_app key do
    templates 'web_app.conf.erb'
    cookbook 'project'
    server_name vhost['server_name']
    server_aliases vhost['aliases']
    docroot vhost['docroot']
    allow_override 'All'
    enable_ssl 'false'
    server_port 80
    server_pool vhost['server_name']
  end

  if vhost['enable_ssl'] == 'true'

    openssl_x509 "/etc/apache2/ssl/#{vhost['server_name']}.crt" do
      common_name "#{vhost['server_name']}"
      org "One Agency"
      org_unit "Web"
      country "BE"
    end

    web_app "#{key}-ssl" do
      templates 'web_app.conf.erb'
      cookbook 'project'
      server_name vhost['server_name']
      server_aliases vhost['aliases']
      docroot vhost['docroot']
      allow_override 'All'
      enable_ssl 'true'
      server_port 443
      server_pool vhost['server_name'] + "-ssl"
    end

  end

end

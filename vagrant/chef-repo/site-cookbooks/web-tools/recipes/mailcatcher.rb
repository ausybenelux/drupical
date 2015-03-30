#
# Cookbook Name::web-tools
# Recipe::mailcatcher
#

if node['config']['web_tools']['tools']['mailcatcher']['install']

  package 'rubygems' do
    action :install
  end

  package 'sqlite3' do
    action :nothing
  end.run_action(:install)

  package 'libsqlite3-dev' do
    action :nothing
  end.run_action(:install)

  package 'libsqlite3-ruby' do
    action :nothing
  end.run_action(:install)

  gem_package "mailcatcher" do
    action :install
  end

  template '/etc/init/mailcatcher.conf' do
    cookbook 'web-tools'
    source 'mailcatcher.conf.erb'
    owner 'root'
    group 'root'
    mode '0655'
    action :create
  end

  url_base = node['config']['web_tools']['url_base']
  tool_alias = node['config']['web_tools']['tools']['mailcatcher']['alias']

  template '/etc/apache2/sites-available/mailcatcher.conf' do
    cookbook 'web-tools'
    source 'mailcatcher.vhost.erb'
    owner 'root'
    group 'root'
    mode '0655'
    variables({:servername => "#{tool_alias}.#{url_base}"})
    action :create
  end

  apache_site 'mailcatcher' do
    enable 'mailcatcher'
  end

  package 'postfix' do
    action :install
  end

  template '/etc/postfix/main.cf' do
    cookbook 'web-tools'
    source 'mailcatcher.vhost.erb'
    owner 'root'
    group 'root'
    mode '0655'
    action :create
  end

  execute "Start mailcatcher" do
    command "mailcatcher"
  end

end
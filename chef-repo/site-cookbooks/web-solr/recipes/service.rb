#
# Cookbook Name:: oa-solr
# Recipe:: service
#
# Copyright (C) 2016 Ausy Belgium nv
#
# All rights reserved - Do Not Redistribute
#

directory node['solr']['log'] do
  mode '0777'
  owner 'solr'
  group 'solr'
  action :create
end

template '/etc/default/jetty' do
  source 'jetty.erb'
  mode '0644'
  variables ({
      'jetty_user' => 'solr',
      'jetty_host' => 'localhost',
      'jetty_port' => '8983',
      'jetty_home' => node['solr']['home'],
      'jetty_log' => node['solr']['log'],
  })
  notifies :restart, 'service[jetty]'
end

cookbook_file '/etc/init.d/jetty' do
  source 'jetty.sh'
  mode '0755'
  notifies :restart, 'service[jetty]'
end

service 'jetty' do
  action [:enable, :start]
end
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

template '/etc/init.d/solr' do
  source 'solr.erb'
  mode '0777'
  variables ({
      'jetty_user' => 'solr',
      'jetty_host' => 'localhost',
      'jetty_port' => '8983',
      'jetty_home' => node['solr']['home'],
      'jetty_log' => node['solr']['log'],
  })
  notifies :restart, 'service[solr]'
end

service 'solr' do
  action [:enable, :start]
end
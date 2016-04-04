#
# Cookbook Name:: oa-solr
# Recipe:: package
#
# Copyright (C) 2016 Ausy Belgium nv
#
# All rights reserved - Do Not Redistribute
#

node.default['solr']['version'] = '3.6.2'

node.default['solr']['link'] = "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/apache-solr-#{node['solr']['version']}.tgz"
node.default['solr']['download'] = "#{node['solr']['src']}/apache-solr-#{node['solr']['version']}.tgz"

package "daemon" do
  action :install
end

user 'solr' do
  shell '/bin/false'
  home node['solr']['home']
  manage_home true
  action :create
end

directory node['solr']['src'] do
  mode '0777'
  owner 'solr'
  group 'solr'
  action :create
end

remote_file node['solr']['download'] do
  source node['solr']['link']
  mode 0644
  not_if {File.exist?(node['solr']['download'])}
end

execute "extract-src" do
  command "tar xzf #{node['solr']['download']} -C #{node['solr']['src']} --strip-components=1"
  notifies :run, 'execute[copy-example]', :immediately
  notifies :run, 'execute[copy-contrib]', :immediately
  notifies :run, 'execute[setup-multicore]', :immediately
  not_if { File.exist?("#{node['solr']['home']}/solr") }
end

execute "copy-example" do
  command "cp -R #{node['solr']['src']}/example/* #{node['solr']['home']}"
  action :nothing
end

execute "copy-contrib" do
  command "cp -R #{node['solr']['src']}/contrib/ #{node['solr']['home']}"
  action :nothing
end

execute "cleanup-example" do
  command "rm -rf #{node['solr']['home']}/example-schemaless && rm -rf #{node['solr']['home']}/example-DIH && rm -rf #{node['solr']['home']}/exampledocs && rm -rf #{node['solr']['home']}/logs"
  action :nothing
end

execute "setup-multicore" do
  command "rm -rf #{node['solr']['home']}/solr && mv #{node['solr']['home']}/multicore #{node['solr']['home']}/solr && rm -rf #{node['solr']['home']}/solr/exampledocs && rm -rf #{node['solr']['home']}/solr/README.txt"
  action :nothing
end

execute "fix-jetty-logging.xml" do
  command "rm -rf #{node['solr']['home']}/contexts/solr-jetty-context.xml"
  notifies :create, 'cookbook_file[contexts/jetty-logging.xml]', :immediately
  action :nothing
end

execute "fix-solr-jetty-context.xml" do
  command "rm -rf #{node['solr']['home']}/contexts/solr-jetty-context.xml"
  notifies :create, 'cookbook_file[contexts/solr-jetty-context.xml]', :immediately
  action :nothing
end

execute "fix-solr.xml" do
  command "rm -rf #{node['solr']['home']}/solr/solr.xml"
  notifies :create, 'cookbook_file[solr/solr.xml]', :immediately
  action :nothing
end

cookbook_file "solr/solr.xml" do
  path "#{node['solr']['home']}/solr/solr.xml"
  source 'solr.xml'
  mode '0755'
  action :nothing
end

cookbook_file "contexts/solr-jetty-context.xml" do
  path "#{node['solr']['home']}/contexts/solr-jetty-context.xml"
  source 'solr-jetty-context.xml'
  mode '0755'
  action :nothing
end

cookbook_file "contexts/jetty-logging.xml" do
  path "#{node['solr']['home']}/etc/jetty-logging.xml"
  source 'jetty-logging.xml'
  mode '0755'
  action :nothing
end

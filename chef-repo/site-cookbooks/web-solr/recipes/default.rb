#
# Cookbook Name:: web-solr
# Recipe:: default
#
# Copyright (C) 2016 Ausy Belgium nv
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'system-java'

if node['config']['solr']['solr_version'] != '3.x' && node['config']['solr']['solr_version'] != '4.x'
  if node['config']['solr']['solr_version'].split(".").first == '3'
    version = '3.x'
  else
    version = '4.x'
  end
else
  version = node['config']['solr']['solr_version']
end

if version == '3.x'
  include_recipe 'web-solr::package_3x'
  include_recipe 'web-solr::service_3x'
else
  include_recipe 'web-solr::package'
  include_recipe 'web-solr::service'
end

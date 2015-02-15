#
# Cookbook Name:: solr
# Recipe:: default
#

Chef::Log.info('Starting drupical::solr')

node.override['java']['jdk_version'] = '7'
node.override['java']['install_flavor'] = 'oracle'
node.override['java']['oracle']['accept_oracle_download_terms'] = true
node.override['java']['jdk']['7']['x86_64']['url'] = "http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u76-linux-x64.tar.gz"

node.override['jetty']['port'] = 8390
node.override['jetty']['version'] = '9.2.7.v20150116'
node.override['jetty']['link'] = 'http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.2.7.v20150116.tar.gz&r=1'
node.override['jetty']['checksum'] = '90d3f9ef886696a62bd93012f463d0054282b395'

node.override['solr']["version"] = node['config']['drupical']['solr']['solr_version']
node.override['solr']["checksum"] = node['config']['drupical']['solr']['solr_checksum']

include_recipe "java"

include_recipe "hipsnip-jetty"

include_recipe "hipsnip-solr"

bash "Adding permissions for solr" do

  if /^(?:1\.4\.(?:0|1){1}|3\.[0-9]{1,}\.[0-9]{1,})/.match(node['config']['drupical']['solr']['solr_version'])
    solr_name = "apache-solr-#{node['config']['drupical']['solr']['solr_version']}"
  elsif /^4\.[0-9]{1,}\.[0-9]{1,}/.match(node['config']['drupical']['solr']['solr_version'])
    solr_name = "solr-#{node['config']['drupical']['solr']['solr_version']}"
  else
    solr_name = ""
  end

  if (solr_name.length > 0)

    code <<-EOH
(sudo chown -R vagrant:vagrant /usr/local/src/#{solr_name})
(rm -rf /usr/share/solr/* && cp -R /usr/local/src/#{solr_name}/example/multicore/* /usr/share/solr/)
(rm -rf /usr/share/solr/core0/conf && ln -s /config/solr/ /usr/share/solr/core0/conf)
(chmod -R 775 /usr/share/solr/ && chown -R jetty.jetty /usr/share/solr/)
    EOH

  end
end

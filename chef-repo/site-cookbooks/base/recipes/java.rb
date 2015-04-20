#
# Cookbook Name::base
# Recipe::java
#

node.override['java']['jdk_version'] = '7'
node.override['java']['install_flavor'] = 'oracle'
node.override['java']['oracle']['accept_oracle_download_terms'] = true

include_recipe "java"
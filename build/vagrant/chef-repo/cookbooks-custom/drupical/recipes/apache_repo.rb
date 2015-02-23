#
# Cookbook Name:: drupical
# Recipe:: apache_repo
#

Chef::Log.info('Starting drupical::apache_repo')

apt_repository "ondrej-apache2" do
  uri "http://ppa.launchpad.net/ondrej/apache2/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["php5"]["keyserver"]
  key node["php5"]["key_ondrej"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end
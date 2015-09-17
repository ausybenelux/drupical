#
# Cookbook Name::web
# Recipe:: apache_repo
#

apt_repository "ondrej-apache2" do
  uri "http://ppa.launchpad.net/ondrej/apache2/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["apache2"]["keyserver"]
  key node["apache2"]["key_ondrej"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_preference "ondrej-apache2" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/ondrej/apache2/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end

#
# Cookbook Name:: php5_ppa
# Recipe:: from_ondrej_old
#

include_recipe "apt"

apt_repository "ondrej-old-php" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["php5"]["keyserver"]
  key node["php5"]["key_ondrej_old"]
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "ondrej-old-php-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end


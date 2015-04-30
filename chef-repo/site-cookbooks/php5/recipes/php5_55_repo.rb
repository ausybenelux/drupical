#
# Cookbook Name:: php5_ppa
# Recipe:: from_ondrej
#

apt_repository "ondrej-php" do
  uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["php5"]["keyserver"]
  key node["php5"]["key_ondrej"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_preference "ondrej-php-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/ondrej/php5/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end



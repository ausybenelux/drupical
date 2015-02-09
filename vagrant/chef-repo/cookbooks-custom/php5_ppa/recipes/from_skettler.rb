#
# Cookbook Name:: php5_ppa
# Recipe:: from_skettler
#

include_recipe "apt"


apt_repository "skettler-php-#{node["lsb"]["codename"]}" do
  uri "http://ppa.launchpad.net/skettler/php/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["php5_ppa"]["keyserver"]
  key node["php5_ppa"]["key_skettler"]
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

apt_preference "skettler-php-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/skettler/php/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end


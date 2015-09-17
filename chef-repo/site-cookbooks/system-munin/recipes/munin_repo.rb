#
# Cookbook Name:: php5_ppa
# Recipe:: from_ondrej_old
#

apt_repository "tuxpoldo-munin" do
  uri "http://ppa.launchpad.net/tuxpoldo/munin/ubuntu"
  components [node["lsb"]["codename"], 'main']
  key 'D294A752'
  keyserver 'keyserver.ubuntu.com'
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "tuxpoldo-munin-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/tuxpoldo/munin/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end


#
# Cookbook Name:: java_repo
# Recipe:: base
#

apt_repository "webupd8team" do
  uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["webupd8team"]["keyserver"]
  key node["webupd8team"]["key"]
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "webupd8team-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/webupd8team/java/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end


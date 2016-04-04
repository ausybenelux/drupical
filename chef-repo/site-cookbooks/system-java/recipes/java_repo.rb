#
# Cookbook Name::system
# Recipe::java_repo
#

apt_repository "webupd8team" do
  uri "http://ppa.launchpad.net/webupd8team/java/ubuntu"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver node["webupd8team"]["keyserver"]
  key node["webupd8team"]["key"]
  action :add
  notifies :run, 'execute[webupd8team-apt-update]', :immediately
end

apt_preference "webupd8team-pin" do
  glob '*'
  pin 'origin http://ppa.launchpad.net/webupd8team/java/ubuntu'
  pin_priority '700'
  notifies :run, "execute[webupd8team-apt-update]", :immediately
end

execute "webupd8team-apt-update" do
  command "apt-get update"
  ignore_failure true
  only_if { apt_installed? }
end

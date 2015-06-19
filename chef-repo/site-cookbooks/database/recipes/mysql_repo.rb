#
# Cookbook Name::database
# Recipe::mysql
#

apt_repository "mysql" do
  uri " http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu"
  components [ node["lsb"]["codename"] ,'main']
  key '1BB943DB'
  keyserver 'keyserver.ubuntu.com'
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "mysql-pin" do
  glob '*'
  pin 'origin  http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end

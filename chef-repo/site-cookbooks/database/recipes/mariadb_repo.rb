#
# Cookbook Name::database
# Recipe::mariadb
#

apt_repository "mariadb" do
  uri "http://mariadb.mirror.nucleus.be//repo/10.0/ubuntu"
  components [ node["lsb"]["codename"] ,'main']
  key '1BB943DB'
  keyserver 'keyserver.ubuntu.com'
  action :add
  notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "mariadb-pin" do
  glob '*'
  pin 'origin http://mariadb.mirror.nucleus.be//repo/10.0/ubuntu'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end

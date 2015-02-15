#
# Cookbook Name:: dotdeb
# Recipe:: php56
#

apt_repository "dotdeb" do
  uri "http://packages.dotdeb.org"
  distribution "wheezy"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  notifies :run, "execute[apt-get update]", :immediately
end

apt_repository "dotdeb-php56" do
  uri "http://packages.dotdeb.org"
  distribution "wheezy-php56"
  components ["all"]
  key "http://www.dotdeb.org/dotdeb.gpg"
  notifies :run, "execute[apt-get update]", :immediately
end

apt_preference "dotdeb-php56-pin" do
  glob '*'
  pin 'origin http://packages.dotdeb.org'
  pin_priority '700'
  notifies :run, "execute[apt-get update]", :immediately
end
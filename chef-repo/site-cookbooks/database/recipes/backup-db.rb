#
# Cookbook Name:: database
# Recipe:: backup-db
#

template "/usr/local/bin/backup-db.sh" do
  source "backup-db.sh.erb"
  mode 0777
  cookbook 'database'
end

file "/var/enable-backup-db" do
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


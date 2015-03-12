#
# Cookbook Name:: drupical
# Recipe:: tasks
#


template "/usr/local/bin/backup-db.sh" do
  source "backup-db.sh.erb"
  mode 0777
  notifies :run, 'execute[create_db_backup_token]', :immediately
end

file "/home/vagrant/drupical/build/backup/file_token" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


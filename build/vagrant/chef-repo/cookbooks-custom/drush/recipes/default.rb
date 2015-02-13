#
# Cookbook Name:: drush
# Recipe:: default
#

bash "install-console-table" do
  code <<-EOH
  (pear install Console_Table)
  EOH
  not_if "pear list| grep Console_Table"
end

git "/usr/share/drush" do
  repository "https://github.com/drush-ops/drush.git"
  reference "6.5.0"
  action :sync
end

bash "make-drush-symlink" do
  code <<-EOH
  (ln -s /usr/share/drush/drush /usr/bin/drush)
  EOH
  not_if { File.exists?("/usr/bin/drush") }
  only_if { File.exists?("/usr/share/drush/drush") }
end

directory "/home/vagrant/.drush" do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end
#
# Cookbook Name:: drush
# Recipe:: default
#

git "/usr/share/drush" do
  repository "git://github.com:drush-ops/drush.git"
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

bash "install-console-table" do
  code <<-EOH
(pear install Console_Table)
  EOH
  not_if "pear list| grep Console_Table"
end

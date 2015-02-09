#
# Cookbook Name:: drupical
# Recipe:: database
#

Chef::Log.info('Starting drupical::database')

include_recipe "mysql::client"
include_recipe "mysql::server"

ruby_block "Ensuring mysql has the correct settings for drupal" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/mysql/my.cnf")
    fe.insert_line_after_match(/\[mysqld\]/, "max_allowed_packet = 100M")
    fe.write_file
  end
end
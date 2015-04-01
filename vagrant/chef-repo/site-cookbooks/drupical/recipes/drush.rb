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

#link "/home/vagrant/build/drush/policy/policy.drush.inc" do
#  to "/home/vagrant/.drush/policy.drush.inc"
#end

vhosts = node['config']['vhosts']
vhosts.each do |key, vhost|

  #
  vhost_aliases = Hash.new

  #
  _aliases = vhost.fetch('aliases')

  vhost_aliases[key] = vhost.fetch('server_name')

  #
  _aliases.each do |_key, _alias|

    vhost_aliases[_key] = _alias

  end

 # template "/home/vagrant/drupical/build/drush/alias/" + key + ".aliases.drushrc.php" do
#
  #  source "aliases.drushrc.php.erb"
  #  mode '0666'
  #  variables({
  #                :server_name  => vhost.fetch('server_name'),
  #                :docroot      => vhost.fetch('docroot'),
  #                :aliases      => vhost_aliases
  #            })

  #end

  #link "/home/vagrant/.drush/" + key + ".aliases.drushrc.php"do
  #  to "/home/vagrant/drupical/build/drush/alias/" + key + ".aliases.drushrc.php"
  #end

end
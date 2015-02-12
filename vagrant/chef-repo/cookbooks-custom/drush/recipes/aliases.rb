#
# Cookbook Name:: drush
# Recipe:: aliases
#

vhosts = node['config']['vhosts']
vhosts.each do |key, vhost|

  #
  vhost_aliases = Array.new

  #
  _aliases = vhost.fetch('aliases')

  #
  _aliases.each do |key, _alias|
    vhost_aliases.push(_alias)
  end

  template "/home/vagrant/.drush/" + key + ".aliases.drushrc.php" do

    source "aliases.drushrc.php.erb"
    mode '0666'
    owner 'vagrant'
    group 'vagrant'
    variables({
      :server_name  => vhost.fetch('server_name'),
      :docroot      => vhost.fetch('docroot'),
      :aliases      => vhost_aliases
    })

  end

end


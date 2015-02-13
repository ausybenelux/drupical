#
# Cookbook Name:: drush
# Recipe:: aliases
#

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

  template "/home/vagrant/drupical/build/drush/alias/" + key + ".aliases.drushrc.php" do

    source "aliases.drushrc.php.erb"
    mode '0666'
    variables({
      :server_name  => vhost.fetch('server_name'),
      :docroot      => vhost.fetch('docroot'),
      :aliases      => vhost_aliases
    })

  end

  link "/home/vagrant/.drush/" + key + ".aliases.drushrc.php"do
    to "/home/vagrant/drupical/build/drush/alias/" + key + ".aliases.drushrc.php"
  end

end


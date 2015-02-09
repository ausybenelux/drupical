#
# Cookbook Name:: drush
# Recipe:: default
#


case node[:platform]
  when "debian", "ubuntu"
    bash "install-drush" do
      code <<-EOH
    (pear install Console_Table)
    (cd /tmp; wget https://github.com/drush-ops/drush/archive/6.5.0.tar.gz)
    (cd /tmp; tar zxvf 6.5.0.tar.gz)
    (cd /tmp; mkdir /var/lib/drush ; cd drush-6.5.0 ; cp -R * /var/lib/drush/)
    (cd /tmp; ln -s /var/lib/drush/drush /usr/bin/drush)
    (cd /tmp; drush dl registry_rebuild)
      EOH
      not_if { File.exists?("/usr/share/drush/drush") }
    end
end

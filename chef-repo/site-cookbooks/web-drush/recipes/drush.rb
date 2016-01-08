#
# Cookbook Name:: web-drush
# Recipe:: drush
#

if node['platform_family'] == 'debian'

  if node['platform'] == 'ubuntu'

    if node['platform_version'].to_f < 13.10

      git "/usr/share/drush" do
        repository "https://github.com/drush-ops/drush.git"
        reference "7.1.0"
        action :sync
      end

      bash "install-console-table-manual" do
        code <<-EOH
            (wget http://download.pear.php.net/package/Console_Table-1.1.3.tgz)
            (tar xvzf Console_Table-1.1.3.tgz)
            (sudo mv Console_Table-1.1.3 /usr/share/drush/lib)
        EOH
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

      bash "drush-autocompletion" do
        code <<-EOH
        (ln -s /usr/share/drush/drush.complete.sh /etc/bash_completion.d/drush.complete.sh)
        EOH
        not_if { File.exists?("/etc/bash_completion.d/drush.complete.sh") }
        only_if { File.exists?("/usr/share/drush/drush.complete.sh") }
      end

    else

      remote_file "/usr/local/bin/drush" do
        source "http://files.drush.org/drush.phar"
        mode 0777
      end

      execute 'symbolic-link-drush' do
        command 'ln -s /usr/local/bin/drush /usr/bin/drush'
      end

    end

  end

end

package "unzip" do
  action :install
end
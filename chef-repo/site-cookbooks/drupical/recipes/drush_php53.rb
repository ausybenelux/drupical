#
# Cookbook Name:: drush_php53
# Recipe:: default
#

package "libxml2-dev" do
  action :install
end

package "libcurl4-openssl-dev" do
  action :install
end

package "libjpeg-dev" do
  action :install
end

package "libpng-dev" do
  action :install
end

package "libxpm-dev" do
  action :install
end

package "libmysqlclient-dev" do
  action :install
end

package "libpq-dev" do
  action :install
end

package "libicu-dev" do
  action :install
end

package "libfreetype6-dev" do
  action :install
end

package "libldap2-dev" do
  action :install
end

package "libxslt-dev" do
  action :install
  end

package "libbz2-dev" do
  action :install
end

package "libmcrypt-dev" do
  action :install
end

package "libtidy-dev" do
  action :install
end

remote_file "/opt/php-5.3.9.tar.gz" do
  source "http://museum.php.net/php5/php-5.3.9.tar.gz"
  mode 0777
end

bash "compile-php53" do
  code <<-EOH
    (chmod 777 /opt)
    (cd /opt && tar xvzf php-5.3.9.tar.gz)
    (cd /opt/php-5.3.9 && ./configure --prefix=/opt/php53 --with-config-file-path=/opt/php53 --without-t1lib --disable-short-tags --with-mysqli=mysqlnd --with-mysql=mysqlnd --with-pdo-mysql --with-openssl --with-zlib --enable-bcmath --with-bz2 --with-gd --enable-mbstring --with-mcrypt --with-mhash --enable-soap --enable-sockets --with-xmlrpc --enable-zip --with-tidy --with-curl --with-curlwrappers)
    (cd /opt/php-5.3.9 && make)
    (cd /opt/php-5.3.9 && make install)
    (chmod -R 777 /opt/php53)
  EOH
end

 template "/etc/profile.d/profile.drush.sh" do

   source "profile.drush.sh"
   mode 0777

 end
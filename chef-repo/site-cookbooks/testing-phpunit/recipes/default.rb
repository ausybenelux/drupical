#
# Cookbook Name:: testing-phpunit
# Recipe:: default
#

Chef::Log.info('Starting testing-phpunit::default')

bash "install-pear" do
  code <<-EOH
  (wget https://phar.phpunit.de/phpunit.phar)
  (chmod +x phpunit.phar)
  (sudo mv phpunit.phar /usr/local/bin/phpunit)
  EOH
end

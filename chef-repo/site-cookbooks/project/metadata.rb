name "project"

maintainer "Bart Arickx"
maintainer_email "bart.arickx@one-agency.be"

license '(c) 2015 -- All rights reserved'

description "Installs/Configures project"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ web-drush database mysql2_chef_gem apache2 composer phing php-fpm }.each do |dependancy|
  depends dependancy
end

recipe 'project::default', ''
recipe 'project::web-database', ''
recipe 'project::web-httpd', ''
recipe 'project::web-php5', ''
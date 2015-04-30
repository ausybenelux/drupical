name "php5"

maintainer "Bart Arickx"
maintainer_email "bart.arickx@one-agency.be"

license '(c) 2015 -- All rights reserved'

description "Installs/Configures php5"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ base apt php phing composer web apache2 php-fpm }.each do |dependancy|
  depends dependancy
end

recipe 'php5::default',  'Main configuration'
recipe 'php5::install',  'Install'
recipe 'php5::packages', 'Packages'
recipe 'php5::php5_54',  'php5_54_ppa'
recipe 'php5::php5_55',  'php5_55_ppa'
recipe 'php5::php5_53',  'php5_56_dotdeb'
recipe 'php5::php_fpm',  'php_fpm'
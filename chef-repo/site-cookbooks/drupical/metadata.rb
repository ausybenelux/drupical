name 'drupical'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures drupical'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{apt apache2 php-fpm}.each do |dependancy|
  depends dependancy
end

recipe 'drupical::site',  'site'
recipe 'drupical::drush', 'drush'
recipe 'drupical::drush_php53', 'drush_php53'

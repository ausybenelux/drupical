name 'web'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures drupical'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apache2 web }.each do |dependency|
  depends dependency
end

recipe 'drupical::default'  ,'default'
recipe 'drupical::drush'    ,'drush configuration'
depends 'openssl'
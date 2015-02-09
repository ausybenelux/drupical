name 'phpmemcachedadmin'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures phpmemcachedadmin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

%w{apache2 php}.each do |dependancy|
  depends dependancy
end

recipe 'phpmemcachedadmin::default', 'Main configuration'

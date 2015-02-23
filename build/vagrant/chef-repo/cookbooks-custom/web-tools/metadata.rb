name 'web-tools'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures webtools'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

%w{apache2 php}.each do |dependancy|
  depends dependancy
end

recipe 'info::default', 'Main configuration'
recipe 'adminer::default', 'Main configuration'
recipe 'opcachegui::default', 'Main configuration'
recipe 'phpmemcachedadmin::default', 'Main configuration'
recipe 'profiler::default', 'Main configuration'

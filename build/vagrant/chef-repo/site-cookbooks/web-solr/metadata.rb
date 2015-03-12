name 'web-solr'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures drupical'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

%w{hipsnip-jetty hipsnip-solr java}.each do |dependancy|
  depends dependancy
end

recipe 'web-solr::default', 'Main configuration'

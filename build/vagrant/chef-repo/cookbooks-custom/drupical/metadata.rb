name 'zsh'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures drupical'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{apt git apache2 composer curl hipsnip-jetty hipsnip-solr java memcached mysql phing php5 varnish vim}.each do |dependancy|
  depends dependancy
end

recipe 'drupical::default', 'dummy'
recipe 'drupical::base', 'Main configuration'
recipe 'drupical::database', 'Database role cookbook'
recipe 'drupical::varnish', 'Varnish role cookbook'
recipe 'drupical::web', 'Web role cookbook'
recipe 'drupical::apache', 'apache role cookbook'
recipe 'drupical::php', 'php role cookbook'

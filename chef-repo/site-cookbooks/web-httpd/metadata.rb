name 'web-httpd'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures httpd'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{apache2 openssl}.each do |dependency|
  depends dependency
end

recipe 'web-httpd::default', 'default'
recipe 'web-httpd::apache', 'apache'
recipe 'web-httpd::apache_repo', 'apache 2.4 repo'

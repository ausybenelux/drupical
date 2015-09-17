name 'web-database'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures database'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{system mysql apt}.each do |dependancy|
  depends dependancy
end

recipe 'web-database::mysql', 'mysql'
recipe 'web-database::mariadb', 'mariadb'
recipe 'web-database::config', 'config'
recipe 'web-database::backup-db', 'backup-db'


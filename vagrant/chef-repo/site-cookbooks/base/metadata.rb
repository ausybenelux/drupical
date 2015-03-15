name 'base'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apt git curl vim java build-essential}.each do |dependancy|
  depends dependancy
end

recipe 'base::default', 'Default'
recipe 'base::apt', 'Apt'
recipe 'base::cachefilesd', 'Cachefilesd'
recipe 'base::extra', 'extra'
recipe 'base::java', 'java'
recipe 'base::extra_zsh', 'Zsh'
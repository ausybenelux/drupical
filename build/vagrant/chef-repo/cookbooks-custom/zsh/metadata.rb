name 'zsh'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures zsh'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.0.1'

recipe 'zsh::default', 'Main configuration'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apt git }.each do |dependancy|
  depends dependancy
end

recipe 'zsh::default', 'Main configuration'

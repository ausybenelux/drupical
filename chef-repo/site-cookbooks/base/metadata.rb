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

%w{ apt git curl vim ruby-ng}.each do |dependancy|
  depends dependancy
end

recipe 'base::default'        , 'Default'
recipe 'base::apt'            , 'Apt'
recipe 'base::build'          , 'Build-essential'
recipe 'base::extra'          , 'Extra'
recipe 'base::extra_zsh'      , 'Zsh'
recipe 'base::java'           , 'Java'
recipe 'base::java_repo'      , 'Java repo'
recipe 'base::ruby'           , 'Ruby'
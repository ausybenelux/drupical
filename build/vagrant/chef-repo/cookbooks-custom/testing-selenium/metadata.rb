name 'testing-selenium'

maintainer 'Bart Arickx'
maintainer_email 'bart.arickx@one-agency.be'

license '(c) 2015 -- All rights reserved'

description 'Installs/Configures drupical'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ nodejs apt selenium }.each do |dependancy|
  depends dependancy
end


recipe 'testing-selenium::default' ,'default'
recipe 'testing-selenium::browsers' ,'browsers'
recipe 'testing-selenium::xvfb', 'xvfb'
recipe 'testing-selenium::chrome' , 'browser_chrome'
recipe 'testing-selenium::firefox' , 'browser_firefox'
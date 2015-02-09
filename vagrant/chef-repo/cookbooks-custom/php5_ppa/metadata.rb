name "php5_ppa"

maintainer "Bart Arickx"
maintainer_email "bart.arickx@one-agency.be"

license '(c) 2015 -- All rights reserved'

description "Installs/Configures php5 from ppa"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ apt }.each do |dependancy|
  depends dependancy
end

recipe 'php5_ppa::default', 'Main configuration'
recipe 'php5_ppa::from_ondrej', 'from_ondrej'
recipe 'php5_ppa::from_ondrej_old', 'from_ondrej_old'
recipe 'php5_ppa::skettler', 'skettler'
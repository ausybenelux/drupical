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

%w{ apt php }.each do |dependancy|
  depends dependancy
end

recipe 'php5::default', 'Main configuration'
recipe 'php5::php5_54_ppa', 'php5_54_ppa'
recipe 'php5::php5_55_ppa', 'php5_55_ppa'
recipe 'php5::php5_56_dotdeb', 'php5_56_dotdeb'
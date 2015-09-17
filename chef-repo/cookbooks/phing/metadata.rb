name             "phing"
maintainer       "Dieter Blomme"
maintainer_email "dieterblomme@gmail.com"
license          "MIT"
description      "Installs/Configures Phing"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{ debian ubuntu redhat centos fedora scientific amazon }.each do |os|
  supports os
end

depends 'php'
depends 'composer'

recipe "phing", "Installs Phing"
recipe "phing::pear", "Installs Phing through PEAR"

name             'web-solr'
maintainer       'Ausy Belgium nv'
maintainer_email 'systems@ausy.be'
license          'All rights reserved'
description      'Installs/Configures oa-solr'
long_description 'Installs/Configures oa-solr'
version          '0.1.0'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ system-java }.each do |dependency|
  depends dependency
end

recipe 'oa-solr::default', ''
recipe 'oa-solr::package', ''
recipe 'oa-solr::service', ''

#
# Cookbook Name::system
# Recipe::java
#

include_recipe "system-java::java_repo"

bash "java-set-debconf-selection" do
  code <<-EOH
    (echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections)
  EOH
end

package "oracle-java7-installer" do
  action :install
end
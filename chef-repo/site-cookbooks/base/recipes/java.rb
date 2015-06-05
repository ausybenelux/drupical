#
# Cookbook Name::base
# Recipe::java
#

bash "java-set-debconf-selection" do
  code <<-EOH
    (echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections)
  EOH
end

include_recipe "base::java_repo"

package "oracle-java7-installer" do
  action :install
end
#
# Cookbook Name::system
# Recipe::cachefilesd
#

package "cachefilesd" do
  action :install
end

file "/etc/default/cachefilesd" do
  content <<-EOS
RUN=yes
  EOS
  action :create
  mode 0755
end
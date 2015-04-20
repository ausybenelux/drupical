#
# Cookbook Name::base
# Recipe::build
#

include_recipe "build-essential"

package 'debconf' do
  action :install
end

package 'debconf-utils' do
  action :install
end
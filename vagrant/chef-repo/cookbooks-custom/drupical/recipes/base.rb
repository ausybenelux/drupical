#
# Cookbook Name:: drupical
# Recipe:: base
#

bash "update-cleanup" do
  code <<-EOH
(apt-get update && apt-get upgrade -y)
(apt-get -y autoremove && apt-get -y clean)
(reset)
  EOH
end

include_recipe "apt"

include_recipe "cachefilesd"

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

include_recipe "zsh"


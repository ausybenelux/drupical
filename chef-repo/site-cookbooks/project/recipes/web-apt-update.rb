#
# Cookbook Name:: web-base
# Recipe::site
#

execute "apt-update" do
  command "apt-get update"
  ignore_failure true
  only_if { apt_installed? }
end

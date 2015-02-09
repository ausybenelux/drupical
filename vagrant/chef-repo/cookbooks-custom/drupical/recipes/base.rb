#
# Cookbook Name:: drupical
# Recipe:: base
#

include_recipe "apt"

include_recipe "cachefilesd"

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

include_recipe "zsh"
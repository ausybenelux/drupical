#
# Cookbook Name::base
# Recipe::extra
#



include_recipe "git"

include_recipe "curl"

include_recipe "vim"

include_recipe "base::extra_zsh"

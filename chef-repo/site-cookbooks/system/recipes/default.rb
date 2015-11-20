#
# Cookbook Name::system
# Recipe::default
#

include_recipe "system::apt"

include_recipe "system::build"

include_recipe "system::cachefilesd"

include_recipe "system::inosync"

include_recipe "system::locale"

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

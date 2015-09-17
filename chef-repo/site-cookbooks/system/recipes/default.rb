#
# Cookbook Name::system
# Recipe::default
#

include_recipe "system::apt"

include_recipe "system::build"

include_recipe "system::extra"

include_recipe "system::java"

include_recipe "system::ruby"

include_recipe "system::cachefilesd"

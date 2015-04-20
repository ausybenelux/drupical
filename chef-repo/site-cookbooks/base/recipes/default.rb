#
# Cookbook Name::base
# Recipe::default
#

include_recipe "base::apt"

include_recipe "base::build"

include_recipe "base::extra"

include_recipe "base::java"

include_recipe "base::ruby"

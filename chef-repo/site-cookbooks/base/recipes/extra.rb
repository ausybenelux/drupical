include_recipe 'build-essential::default'

include_recipe "git"

include_recipe "curl"

include_recipe "vim"

if node['config']['box_shell'] == 'zsh'
  include_recipe "base::extra_zsh"
end

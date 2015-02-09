#
# Cookbook Name:: drupical
# Recipe:: zsh
#

Chef::Log.info('Starting drupical::zsh')

include_recipe "git"

package "zsh" do
  action :install
end

package "zsh-doc" do
  action :install
end

bash "install-zsh" do
  code <<-EOH
(git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh && chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh)
(cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc)
(chsh --shell /bin/zsh vagrant)
  EOH
  not_if { File.exists?("/home/vagrant/.zshrc") }
end

#
# Cookbook Name::system
# Recipe::zsh
#

package "zsh" do
  action :install
end

package "zsh-doc" do
  action :install
end

git "/home/vagrant/.oh-my-zsh" do
  repository "http://github.com/robbyrussell/oh-my-zsh.git"
  action :sync
end

bash "install-zsh" do
  code <<-EOH
  (chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh)
  (cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc)
  EOH
  not_if { File.exists?("/home/vagrant/.zshrc") }
end

#bash "set-zsh" do
#  code <<-EOH
#    (chsh --shell /bin/zsh vagrant)
#  EOH
#  only_if { File.exists?("/home/vagrant/.zshrc") }
#end


package 'xvfb' do
	action :install
end

package 'x11-xkb-utils' do
	action :install
end

package 'xfonts-100dpi' do
	action :install
end

package 'xfonts-75dpi' do
	action :install
end

package 'xfonts-scalable' do
	action :install
end

package 'xserver-xorg-core' do
	action :install
end

package 'dbus-x11' do
	action :install
end

bash "add-xvfb" do
  code <<-EOH
  	(sudo sh -c 'echo "DISPLAY=:0" >> /etc/environment')
  EOH
end

template "/etc/init.d/xvfb" do
	source "xvfb"
	mode 0777
end

service "xvfb" do
  supports :restart => true, :start => true, :stop => true
  action :enable
  subscribes :restart, "template[/etc/init.d/xvfb]", :immediately
end
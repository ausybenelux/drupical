include_recipe 'testing-selenium::firefox_repo'

package 'libdbus-glib-1-2' do
	action :install
end

package 'firefox-mozilla-build' do
	action :install
end
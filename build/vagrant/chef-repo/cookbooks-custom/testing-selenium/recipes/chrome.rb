
include_recipe 'testing-selenium::chrome_repo'

package 'libxss1' do
	action :install
end

package 'libappindicator1' do
	action :install
end

package 'libindicator7' do
	action :install
end

package 'google-chrome-stable' do
	action :install
end
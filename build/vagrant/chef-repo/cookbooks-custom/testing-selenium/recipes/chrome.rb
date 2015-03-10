
include_recipe 'testing-selenium::chrome_repo'

package 'libxss1' do
	action :install
end

package 'libexif-dev' do
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

bash "install-chromedriver" do
  code <<-EOH
  (wget http://chromedriver.storage.googleapis.com/2.14/chromedriver_linux64.zip)
  (unzip chromedriver_linux64.zip)
  (chmod +x chromedriver)
  (sudo mv chromedriver /usr/local/selenium/drivers/chromedriver/)
  EOH
end

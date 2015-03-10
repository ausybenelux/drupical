
selenium_hub 'selenium_hub' do
  host 'localhost'
  action :install
end

selenium_node 'selenium_node' do
  host 'localhost'
  hubHost 'localhost'
  capabilities [
    {
      browserName: 'chrome',
      maxInstances: 5,
      seleniumProtocol: 'WebDriver'
    },
    {
      browserName: 'firefox',
      maxInstances: 5,
      seleniumProtocol: 'WebDriver'
    }
  ]
  action :install
end

file "/etc/init.d/selenium_node" do
  action :delete
  only_if { File.exists?("/etc/init.d/selenium_node") }
end

template "/etc/init.d/selenium_node" do
  source "selenium_node"
  mode 0777
end

include_recipe 'testing-selenium::xvfb'

include_recipe 'testing-selenium::browsers'

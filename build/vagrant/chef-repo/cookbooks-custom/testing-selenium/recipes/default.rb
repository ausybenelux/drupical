
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
    }
  ]
  action :install
end

include_recipe 'testing-selenium::xvfb'

include_recipe 'testing-selenium::browsers'

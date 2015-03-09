
include_recipe 'testing-selenium::xvfb'

include_recipe 'testing-selenium::browsers'

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
    },
    {
      browserName: 'htmlunit',
      maxInstances: 1,
      platform: 'ANY',
      seleniumProtocol: 'WebDriver'
    }
  ]
  action :install
end
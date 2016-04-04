package 'php5-memcached' do
  action :install
  notifies :restart, 'service[apache2]'
end

service 'apache2' do
  action [:restart]
end

if node['platform_version'].to_f >= 14.04
  service 'php5-fpm' do
    action [:restart]
  end
end
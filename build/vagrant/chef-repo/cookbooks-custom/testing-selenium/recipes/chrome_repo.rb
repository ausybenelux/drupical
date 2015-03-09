
apt_repository 'dl.google.com' do
	uri 'https://dl-ssl.google.com/linux/chrome/deb'
	components ['stable','main']
	key 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
  	action :add
  	notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "dl.google.com" do
	glob '*'
	pin 'origin https://dl-ssl.google.com/linux/chrome/deb'
	pin_priority '700'
	notifies :run, "execute[apt-get update]", :immediately
end
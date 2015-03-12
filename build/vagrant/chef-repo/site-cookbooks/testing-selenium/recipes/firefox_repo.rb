
apt_repository 'ubuntuzilla' do
	uri 'http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt'
	components ['all','main']
  	keyserver 'keyserver.ubuntu.com'
  	key 'C1289A29'
  	action :add
  	notifies :run, 'execute[apt-get update]', :immediately
end

apt_preference "ubuntuzilla" do
	glob '*'
	pin 'origin http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt'
	pin_priority '700'
	notifies :run, "execute[apt-get update]", :immediately
end
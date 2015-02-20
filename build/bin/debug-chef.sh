#! /bin/sh

cd /tmp/vagrant-chef-1
chef-solo -c solo.rb -j dns.json
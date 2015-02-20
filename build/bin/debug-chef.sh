#! /bin/bash

cd /tmp/vagrant-chef-3
sudo chef-solo -c solo.rb -j dna.json

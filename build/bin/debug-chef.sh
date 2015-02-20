#! /bin/bash

cd /tmp/vagrant-chef
sudo chef-solo -c solo.rb -j dna.json
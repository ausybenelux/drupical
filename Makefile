.PHONY: info install-chef-librarian download-chef-cookbooks install-vagrant-dependencies make-drupal vagrant-provision vagrant-up

PWD = $(shell pwd | sed 's/\ /\\\ /g')

VAGRANTPLUG = $(shell vagrant plugin list)

BIN_BREW := $(shell brew --version 2>/dev/null)
BIN_VAGRANT := $(shell vagrant -v 2>/dev/null)
BIN_VIRTUALBOX := $(shell VBoxManage --version 2>/dev/null)
BIN_LIBRARIAN := $(shell librarian-chef version 2>/dev/null)
UNAME = $(shell uname -s)


default: vagrant-up

info:
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make info (this)"
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make install (Install all requirements and vagrant up)"
	@echo "make install-vagrant-base"
	@echo "make install-vagrant-plugins"
	@echo "make install-chef-base (Install chef librarian & downloads chef cookbooks)"
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make install-homebrew"
	@echo "make install-virtualbox"
	@echo "make install-vagrant"
	@echo "make install-vagrant-plugins"
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make install-chef-librarian"
	@echo "make download-chef-cookbooks"
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make vagrant-provision"
	@echo "make vagrant-up"
	@echo "make vagrant-destroy"
	@echo "------------------------------------------------------------------------------------------------------------"
	@echo "make vagrant-export"
	@echo "------------------------------------------------------------------------------------------------------------"

install : install-vagrant-base install-vagrant-plugins install-chef-base vagrant-up

install-chef-base : install-chef-librarian download-chef-cookbooks

install-vagrant-base : install-homebrew install-virtualbox install-vagrant

install-vagrant-plugins: check-nfs check-triggers check-hostsupdater check-cachier check-vbguest check-omnibus check-persistent-storage check-hostmanager check-reload

install-homebrew:
ifndef BIN_BREW
ifeq ($(UNAME), Darwin)
		@echo "Installing Homebrew."
		$$(curl -sS https://raw.githubusercontent.com/Homebrew/install/master/install | ruby)
endif

ifeq ($(UNAME), Linux)
		@echo "Installing prerequisites. We assume you already installed ruby 2.0 or higher."
		sudo apt-get update && sudo apt-get install -y build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev 
		@echo "Installing Linuxbrew"
		echo '\r' | ruby -e "$$(curl -sSfL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
		echo 'export PATH="$$HOME/.linuxbrew/bin:$$PATH"' >> ~/.bashrc
		echo 'export MANPATH="$$HOME/.linuxbrew/share/man:$$MANPATH"' >> ~/.bashrc
		echo 'export INFOPATH="$$HOME/.linuxbrew/share/info:$$INFOPATH"' >> ~/.bashrc
endif
else
	@echo "Homebrew is already installed."
endif

install-virtualbox:
ifndef BIN_VIRTUALBOX
	@echo "Installing Virtualbox."
	brew install Caskroom/cask/virtualbox
else
	@echo "Virtualbox is already installed."
endif

install-vagrant:
ifndef BIN_VAGRANT
	@echo "Installing Vagrant."
	brew install Caskroom/cask/vagrant
	brew install Caskroom/cask/vagrant-manager
else
	@echo "Vagrant is already installed."
endif

install-chef-librarian:
ifndef BIN_LIBRARIAN
	@echo "Installing gem librarian chef."
	sudo gem install librarian-chef
else
	@echo "librarian chef is already installed."
endif

download-chef-cookbooks:
	@echo "Downloading chef cookbooks."
	cd $(PWD)/chef-repo ; librarian-chef install --clean --verbose

check-nfs:
ifeq ($(UNAME),Linux)
		@echo "We assume we can do sudo for this part."
		sudo apt-get update
		sudo apt-get install -y nfs-kernel-server
endif

vagrant-up:
	ssh-add -K ~/.ssh/id_rsa ; vagrant up 

vagrant-provision:
	@echo "Re-provisioning vagrant box."
	vagrant reload  --provision

vagrant-destroy:
	@echo "Destroying vagrant box."
	vagrant destroy -f  

check-triggers:
ifneq (,$(findstring triggers, $(VAGRANTPLUG)))
	@echo "Vagrant triggers is already installed"
else
	vagrant plugin install vagrant-triggers
endif

check-hostsupdater:
ifneq (,$(findstring hostsupdater, $(VAGRANTPLUG)))
	@echo "Vagrant hostsupdater is already installed"
else
	vagrant plugin install vagrant-hostsupdater
endif

check-cachier:
ifneq (,$(findstring cachier, $(VAGRANTPLUG)))
	@echo "Vagrant cachier is already installed"
else
	vagrant plugin install vagrant-cachier
endif

check-vbguest:
ifneq (,$(findstring vbguest, $(VAGRANTPLUG)))
	@echo "Vagrant vbguest is already installed"
else
	vagrant plugin install vagrant-vbguest
endif

check-omnibus:
ifneq (,$(findstring omnibus, $(VAGRANTPLUG)))
	@echo "Vagrant omnibus is already installed"
else
	vagrant plugin install vagrant-omnibus
endif

check-persistent-storage:
ifneq (,$(findstring persistent, $(VAGRANTPLUG)))
	@echo "Vagrant persistent-storage is already installed"
else
	vagrant plugin install vagrant-persistent-storage
endif

check-hostmanager:
ifneq (,$(findstring hostmanager, $(VAGRANTPLUG)))
	@echo "Vagrant hostmanager is already installed"
else
	vagrant plugin install vagrant-hostmanager
endif

check-hostmanager:
ifneq (,$(findstring hosts, $(VAGRANTPLUG)))
	@echo "Vagrant hosts is already installed"
else
	vagrant plugin install vagrant-hosts
endif

check-reload:
ifneq (,$(findstring reload, $(VAGRANTPLUG)))
	@echo "Vagrant reload is already installed"
else
	vagrant plugin install vagrant-reload
endif

vagrant-export:
	rm precise64-drupical_0.0.1.box
	vagrant box remove precise64-drupical
	vagrant destroy -f
	vagrant up
	vagrant package --output 'precise64-drupical_0.0.1.box'
	vagrant box add 'precise64-drupical file://./precise64-drupical_0.0.1.box

vagrant-cleanup-interfaces:
	vboxmanage hostonlyif remove vboxnet0
	vboxmanage hostonlyif remove vboxnet1
	vboxmanage hostonlyif remove vboxnet2
	vboxmanage hostonlyif remove vboxnet3
	vboxmanage hostonlyif remove vboxnet4
	vboxmanage hostonlyif remove vboxnet5
	vboxmanage hostonlyif remove vboxnet6
	vboxmanage hostonlyif remove vboxnet7
	vboxmanage hostonlyif remove vboxnet8
	vboxmanage hostonlyif remove vboxnet9
	vboxmanage hostonlyif create

SHELL        := $(shell which bash)
.SHELLFLAGS = -c
.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

PWD = $(shell pwd | sed 's/\ /\\\ /g')

BIN_BREW := $(shell brew --version 2>/dev/null)
BIN_VAGRANT := $(shell vagrant -v 2>/dev/null)
BIN_VIRTUALBOX := $(shell VBoxManage --version 2>/dev/null)
BIN_LIBRARIAN := $(shell librarian-chef version 2>/dev/null)

VAGRANT_PLUGINS := $(shell vagrant plugin list)
VAGRANT_ENVIRONMENT := $(shell uname -s)

default: vagrant-up

info:
	@echo ""
	@echo "make info"
	@echo "make help"
	@echo "make install"
	@echo "make vagrant-up"
	@echo "make check-environment"
	@echo ""

help:
	@echo ""

install: check-environment download-chef-cookbooks vagrant-up

download-chef-cookbooks:
	@echo "Downloading chef cookbooks."
	cd $(PWD)/chef-repo ; librarian-chef install --clean --verbose

vagrant-up:
ifeq "$(wildcard .vagrant)" ""
	make install
endif
	ssh-add -K ~/.ssh/id_rsa ; vagrant up

vagrant-provision:
	@if make .prompt-yesno message="Do you want to continue?" 2> /dev/null; then \
		vagrant reload --provision
	fi; \

vagrant-destroy:
	@if make .prompt-yesno message="Do you want to continue?" 2> /dev/null; then \
		vagrant destroy -f
	fi; \

check-environment: check-environment-virtualbox check-environment-vagrant check-environment-librarian check-vagrant-plugins

check-environment-virtualbox:
ifndef BIN_VIRTUALBOX
	@echo "Virtualbox has not been installed yet."
	@echo "Please install the latest version from https://www.virtualbox.org/wiki/Downloads."
	exit 2;
endif
	@echo "Virtualbox: OK"

check-environment-vagrant:
ifndef BIN_VAGRANT
	@echo "Vagrant has not been installed yet."
	@echo "Please install the version 1.7.1 from http://www.vagrantup.com/download-archive/v1.7.1.html."
	exit 2;
endif
	@echo "Vagrant: OK"

check-environment-librarian:
ifndef BIN_LIBRARIAN
	@echo "Chef-Librarion has not been installed."
	@echo "Installing Chef-Librarion."
	gem install librarian-chef
endif
	@echo "Chef-Librarian: OK"

check-environment-brew:
ifndef BIN_BREW
	@echo "Homebrew has not been installed yet."
ifneq ($(UNAME),Linux)
	exit 2;
endif

endif
	@echo "Homebrew: OK"

check-vagrant-plugins: check-environment-vagrant
	vagrant plugin install vagrant-cachier --verbose --plugin-version '1.2.0'
	vagrant plugin install vagrant-hostmanager --verbose --plugin-version '1.5.0'
	vagrant plugin install vagrant-hosts --verbose --plugin-version '2.4.0'
	vagrant plugin install vagrant-hostsupdater --verbose --plugin-version '0.0.11'
	vagrant plugin install vagrant-omnibus --verbose --plugin-version '1.4.1'
	vagrant plugin install vagrant-persistent-storage --verbose --plugin-version '0.0.16'
	vagrant plugin install vagrant-reload --verbose --plugin-version '0.0.1'
	vagrant plugin install vagrant-share --verbose --plugin-version '1.1.4'
	vagrant plugin install vagrant-triggers --verbose --plugin-version '0.5.0'
	vagrant plugin install vagrant-vbguest --verbose --plugin-version '0.10.0'

.prompt-yesno:
	@exec 9<&0 0</dev/tty
	echo "$(message) [Y]:"
	[[ -z $$FOUNDATION_NO_WAIT ]] && read -rs -t5 -n 1 yn;
	exec 0<&9 9<&-
	[[ -z $$yn ]] || [[ $$yn == [yY] ]] && echo Y >&2 || (echo N >&2 && exit 1)

.PHONY: info install-librarian download-cookbooks

PWD = $(shell pwd)

default: info

info:
	@echo "make info (this)"
	@echo "make install-librarian"
	@echo "make download-cookbooks"

install-librarian:
	gem install librarian-chef

download-cookbooks:
	cd $(PWD)/vagrant/chef-repo ; librarian-chef install --clean --verbose


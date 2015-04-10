# Drupical

Drupical is an easily configurable Vagrant box for developing Drupal projects.

## Quickstart

## Installation

### Including Drupical in your Project

Drupical should be set up as a sub directory of your project's repository. Ideally your repository looks like this:

- docroot (your Drupal code)
- vagrant (the Drupical code)
- ... (other project files and directories)

Follow these steps for inlcuding the latest version of Drupical in your project:

```bash
cd /to/your/project/dir/root
```
```bash
git clone --depth=1 git@github.com:ONEAgency/drupical.git vagrant && rm -rf vagrant/.git
```

You can also add Drupical as a submodule if you want to keep track of changes:

```bash
git submodule add git@github.com:ONEAgency/drupical.git vagrant
```

### Configuring Drupical for your Project

You can configure Drupical by creating your own `local.vagrant.settings.json` settings file. The file will override all settings found in `default.vagrant.settings.json`. See the **Configuration** topic for a full reference.

The most important configuration options are:

Property | Default | Description
---------|---------|------------
box_name | drupal | The name identifying your Vagrant box
vagrant_synced_folders | | A list of folders to sync with Vagrant
vhosts | | A list of apache2 vhosts
solr.solr_install | false | Include solr
solr.solr_version | 3.6.2 | The solr version
rmdbs.root_password | 10moioui | The MySQL root user password
mysql.root_password | 10moioui | The MySQL root user password
varnish_install | true | Include varnish
php.php_version | 5.5 | The PHP version that will be installed

### Provisioning the Vagrant Box

Execute the following commands inside the vagrant folder.

OSX:

```bash
make install
```

Ubuntu:

```bash
sudo apt-get install virtualbox 
sudo apt-get install vagrant
make install-chef-base
make install-vagrant-plugins
make vagrant-up
```

## Usage

## Configuration

## Troubleshooting

## Contributing

https://github.com/applicationsonline/librarian-chef

[![Stories in Ready](https://badge.waffle.io/ONEAgency/drupical.png?label=ready&title=Ready)](https://waffle.io/ONEAgency/drupical)
# Drupical

Drupical is an easily configurable Vagrant box for developing Drupal projects.

The Vagrant box comes with the following software:

- Ubuntu 12.04 LTS 64
- Ubuntu 14.04 LTS 64
- PHP 5.3 (Ubuntu 12.04 LTS 64 / precise64)
- PHP 5.5 (Ubuntu 14.04 LTS 64 / trusty64)
- MySQL5
- Apache2
- Solr
- Memcache
- Varnish
- Composer
- Phing
- Nodejs
- Grunt
- Ruby2
- OpenSSL

## Quickstart

### 1. Include the repository

Inside the root of your repository:

```bash
git clone --depth=1 git@github.com:ONEAgency/drupical.git vagrant && cd vagrant && rm -rf .git
```

### 2. Set up your project configuration:

```bash
cp example.vagrant.settings.json local.vagrant.settings.json
```

In `local.vagrant.settings.json`:

- Replace all instances of `PROJECT_NAME` with the machine name of your project (e.g. my_project) and `SITE_HOST` with the local host name (e.g. my-project.local).
- If your Drupal docroot is not located at /docroot in your repo change `"source" : "../docroot"` to the path of your Drupal docroot, relative to the vagrant directory.

### 3. Provision the box

```bash
rake
```

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
box_type | oa/drupical-trusty64-base | Choose ubuntu flavor, oa/drupical-trusty64-base / oa/drupical-precise64-base
box_url | http://192.168.13.241/one-agency/drupical/trusty64/drupical-trusty64-base.php | http://192.168.13.241/one-agency/drupical/trusty64/drupical-trusty64-base.php / http://192.168.13.241/one-agency/drupical/precise64/drupical-precise64-base.php
vagrant_synced_folders | | A list of folders to sync with Vagrant
vhosts | | A list of apache2 vhosts
solr.solr_install | false | Install solr, possible values true / false
solr.solr_version | 3.6.2 / 4.10.4 | The solr version
rmdbs.root_password | 10moioui | The MySQL root user password
rmdbs.use-mysql-persistent-storage | false | Use persistent storage for mysql database, possible values true / false
varnish_install | true | Install varnish, possible values true / false
php.php_version | 5.x | The PHP version that will be installed
php.enable_php_phing | false | Install phing, possible values true / false
php.enable_php_composer | false | Install composer, possible values true / false
php.enable_php_drush | true | Install drush, possible values true / false

### Provisioning the Vagrant Box

Execute the following commands inside the vagrant folder.

OSX:

```bash
rake
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

### Managing the Vagrant box

You can manage your box with the following commands. Execute them from the vagrant directory:

Command | Description
--------|------------
`vagrant up` | Boot
`vagrant reload` | Reboot
`vagrant ssh` | Log in via SSH
`vagrant halt` | Power off
`vagrant suspend` | Sleep
`vagrant destroy -f` | Remove the box (run `vagrant up --provision` to set it up again).

More information is available in the [official Vagrant documentation](https://docs.vagrantup.com/v2/cli/index.html).

### Accessing your files

By default the parent directory of the box is mounted on /vagrant. 

**Example:**

Host machine path: `/Users/Tyrion/projects/example/docroot/sites`

Vagrant path: `/Users/Tyrion/projects/example/vagrant`

Path on the Vagrant box (log in via `vagrant ssh`): `/vagrant/docroot/sites`

### Managing your database

You can easily manage your database using the included [Adminer DB manager](http://adminer.tools.drupical.local/).

If you prefer a native app like SequelPro follow these instructions:

- In the vagrant dir, run `vagrant ssh-config`
- Copy the `IdentityFile` path
- Execute `ssh-add -K /path/to/identityfile`
- In SequelPro, create a new connection of type SSH
- MySQL Host: 127.0.0.1
- Username: root
- Password: 10moioui
- SSH Host: your project's hostname (e.g. my-project.local)
- SSH User: vagrant

## Configuration

## Troubleshooting

*If your issue is not listed below, please reboot your machine.*

Problem | Solution
--------|---------
Permission error on a log directory when booting. | On the host machine, remove all but the `.gitkeep` file in the `logs` directory and run `vagrant reload`.
mount.nfs: access denied error | Run `rake emergency_fix:nfs`.
403 / Forbidden error when visiting the site in a browser | Run `rake core:reload`.
No connection error when going to the website in a browser | Run `rake maintenance:restart_apache` && `rake maintenance:restart_mysql`.
Box in wrong state error | Run `rake core:destroy`, remove the .vagrant directory and check if there are corrupt devices that should be removed in VirtualBox -> File -> Virtual Media Manager.
Network interface is defined twice | Install most recent version of vagrant.
There was an error while executing `VBoxManage` | Run `rake emergency_fix:forcekill` && `rake core:reload`. If that fails, restart your machine.
Vagrant won't boot after cancelling vagrant up with cmd + c | Run `rake emergency_fix:forcekill` && `rake core:reload`. If that fails, restart your machine.
Vagrant won't start: "A virtual machine with the name xxx123 already exists" | Run `rake core:destroy`, remove the .vagrant directory and check if there are corrupt devices that should be removed in VirtualBox -> File -> Virtual Media Manager.



## Contributing

See the [contribution guidelines](https://github.com/ONEAgency/drupical/wiki/Contributing) in the wiki.

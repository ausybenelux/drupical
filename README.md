[![Stories in Ready](https://badge.waffle.io/ONEAgency/drupical.png?label=ready&title=Ready)](https://waffle.io/ONEAgency/drupical)
# Drupical

Drupical is an easily configurable Vagrant box for developing Drupal projects.

The Vagrant box comes with the following software:

- Ubuntu 12.04 LTS 64 OR Ubuntu 14.04 LTS 64
- PHP 5.3 (Ubuntu 12.04 LTS 64 / precise64) OR PHP 5.5 (Ubuntu 14.04 LTS 64 / trusty64)
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
box_url |  | Depends on ubuntu flavor, see default.vagrant.settings.json
vagrant_synced_folders | | A list of folders to sync with Vagrant
vhosts | | A list of apache2 vhosts
solr.solr_install | false | Install solr, possible values are true / false
solr.solr_version | 3.6.2 / 4.10.4 | The solr version
rmdbs.root_password | 10moioui | The MySQL root user password
rmdbs.use-mysql-persistent-storage | false | Use persistent storage for mysql database, possible values are true / false. Limited to 5GB.
varnish_install | true | Install varnish, possible values are true / false
php.php_version | 5.x | The PHP version that will be installed
php.enable_php_phing | false | Install phing, possible values are true / false
php.enable_php_composer | false | Install composer, possible values are true / false
php.enable_php_drush | true | Install drush, possible values are true / false

### Provisioning the Vagrant Box

Execute the following commands inside the vagrant folder.

OSX:

```bash
rake
```
OR
```bash
rake core:up
```

Ubuntu:

```bash
sudo apt-get install virtualbox 
sudo apt-get install vagrant
rake environment:install_dependencies_vagrant 
rake core:up
```

## Usage

### Managing the Vagrant box

You can manage your box with the following commands. Execute them from the vagrant directory:

Command |Rake command | Description
--------|-------------|------------
`ssh-add -K ~/.ssh/id_rsa && vagrant up` | `rake core:up` | Boot
`vagrant reload` | `rake core:reload` | Reboot
`vagrant ssh` | `rake core:ssh` | Log in via SSH
`vagrant halt` | `rake core:halt` | Power off
`vagrant suspend` | `rake core:suspend` | Sleep
`vagrant destroy` | `rake core:destroy` | Remove the box (run `vagrant up` OR `rake core:up` to set it up again).

For full overview of all Rake commands: `rake -T` 
More information is also available in the [official Vagrant documentation](https://docs.vagrantup.com/v2/cli/index.html).

### Accessing your files

By default the parent directory of the box is mounted on /vagrant. 

**Example:**

Host machine path: `/Users/Tyrion/projects/example/docroot/sites`

Vagrant path: `/Users/Tyrion/projects/example/vagrant`

Path on the Vagrant box (log in via `vagrant ssh`): `/vagrant/docroot/sites`

### Managing your database

If you prefer a native app like SequelPro follow these instructions:

- In the vagrant dir, run `vagrant ssh-config`
- Copy the `IdentityFile` path
- Execute `ssh-add -K /path/to/identityfile`
- In SequelPro, create a new connection of type SSH
- MySQL Host: 127.0.0.1
- Username: root
- Password: your project's rmdbs password (e.g. 10moioui)
- SSH Host: your project's hostname (e.g. my-project.local)
- SSH User: vagrant
- SSH Port: see output `vagrant ssh-config`

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

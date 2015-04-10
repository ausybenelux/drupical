# Drupical

Drupical is an easily configurable Vagrant box for developing Drupal projects.

The Vagrant box comes with the following software:

- Ubuntu 12.04 LTS 64
- PHP 5.5, 5.4 or 5.3
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
- Selenium
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
make install
```

### 4. Setup your project

**TODO**

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

### Managing the Vagrant box

You can manage your box with the following commands. Execute them from the vagrant directory:

Command | Description
--------|------------
`vagrant up` | Boot
`vagrant reload` | Reboot
`vagrant ssh` | Log in via SSH
`vagrant halt` | Power off
`vagrant suspend` | Sleep
`vagrant destroy` | Remove the box (run `vagrant up --provision` to set it up again).

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

Problem | Solution
--------|---------
Permission error on a log directory when booting. | On the host machine, remove all but the `.gitkeep` file in the `logs` directory and run `vagrant reload`.
mount.nfs: access denied error | On the host machine, run `sudo rm /etc/exports` and `vagrant reload`
403 / Forbidden error when visiting the site in a browser | Run `vagrant reload` on the host machine
No connection error when going to the website in a browser | SSH into the machine and run `sudo apache2ctl start`

## Contributing

https://github.com/applicationsonline/librarian-chef

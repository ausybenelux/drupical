# -*- mode: ruby -*-
# vi: set ft=ruby :

begin

  load './build/vagrant/include/helper.rb'
  rescue LoadError

end

begin

  #
  vagrant_check_requirements()

  #
  vconfig = vagrant_get_config()

  #
  aliases = vagrant_get_alias(vconfig)

end

Vagrant.configure(2) do |config|

  #
  config.vagrant.host = :detect

  #
  config.vm.box = vconfig['config']['box_type']
  config.vm.box_check_update = false

  #
  config.omnibus.chef_version = '11'

  # Hostname
  config.vm.hostname = vconfig['config']['box_name']

  # Forward Agent
  config.ssh.forward_agent = true

  # Cache
  config.cache.auto_detect = true
  config.cache.scope = :box
  config.cache.enable :apt
  config.cache.enable :chef

  # Fix NFS permission issues
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid

  # Synced folders
  vconfig['config']['vagrant_synced_folders'].each do |key, value|
    src = File.expand_path(value.fetch('source'))
    config.vm.synced_folder src,
                            value.fetch('target'),
                            type: value.fetch('type'),
                            mount_options: value.fetch('mount_options')
  end

  # Virtualbox
  config.vm.provider "virtualbox" do |vb|

    # Name
    vb.name = vconfig['config']['box_hostname']

    # GUI
    vb.gui = vconfig['config']['box_gui']

    # IP
    if vconfig['config']['box_dhcp'] == true
      config.vm.network "private_network", type: "dhcp"
    elsif vconfig['config']['box_static_ip'].length > 0
      config.vm.network :private_network, ip: vconfig['config']['box_static_ip']
    end

    # Ports
    vconfig['config']['vagrant_ports'].each do |key, value|

      config.vm.network :forwarded_port,
                        host: value.fetch('host'),
                        guest: value.fetch('guest')

    end

    # RAM and CPU
    if vconfig['config']['box_ram_cpu'] == "auto"
      host = RbConfig::CONFIG['host_os']
      if host =~ /darwin/
        vb.cpus = `sysctl -n hw.ncpu`.to_i
        vb.memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      else
        vb.memory = vconfig['config']['box_ram']
        vb.cpus = vconfig['config']['box_cpu']
      end
    else
      vb.memory = vconfig['config']['box_ram']
      vb.cpus = vconfig['config']['box_cpu']
    end

  end

  if Vagrant.has_plugin?("vagrant-hostmanager")

    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      if vm.id
        `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
      end
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.hostmanager.aliases = aliases

  end

  if Vagrant.has_plugin?("vagrant-persistent-storage")

    config.persistent_storage.enabled = true
    config.persistent_storage.use_lvm = false
    config.persistent_storage.location = ".vagrant/storage/mysql-hdd.vdi"
    config.persistent_storage.size = 5000
    config.persistent_storage.mountname = 'mysql'
    config.persistent_storage.filesystem = 'ext4'
    config.persistent_storage.mountpoint = '/var/lib/mysql'

  end

  # Provisioning
  config.vm.provision :chef_solo do |chef|

    #
    chef.json = vconfig

    #
    if vconfig['config']['vagrant_debugging']
      puts 'Vagrant debugging on.'
      chef.arguments = '-l debug -Fdoc'
      chef.log_level = :debug
    else
      puts 'Vagrant debugging off.'
    end

    #
    chef.environment = "vagrant"

    #
    chef.environments_path = "./build/vagrant/chef-repo/environments"

    #
    chef.cookbooks_path = [
        "./build/vagrant/chef-repo/cookbooks",
        "./build/vagrant/chef-repo/cookbooks-custom"
    ]

    #
    chef.roles_path = "./build/vagrant/chef-repo/roles"

    #
    chef.data_bags_path = './build/vagrant/chef-repo/data_bags'

    #
    chef.add_role("base")

    #
    #chef.add_role("database")

    #
    if vconfig['config']["drupical"]["php"]["php_version"] == "5.3"
      chef.add_role("web-php53")
    elsif vconfig['config']["drupical"]["php"]["php_version"] == "5.4"
      chef.add_role("web-php54")
    elsif vconfig['config']["drupical"]["php"]["php_version"] == "5.5"
      chef.add_role("web-php55")
    end

    #
    chef.add_role("web")

    #
    #chef.add_role("web-tools")

    #
    if vconfig['config']["drupical"]['solr']['solr_install']
      chef.add_role("solr")
    end

    #
    if vconfig['config']["drupical"]['varnish_install']
      chef.add_role("varnish")
    end

  end

end
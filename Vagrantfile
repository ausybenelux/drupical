# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

begin

  load 'include/helper.rb'

rescue
    LoadError

end

begin

  #
  vagrant_check_requirements()

  #
  vconfig = vagrant_get_config()

  #
  aliases = vagrant_get_aliases(vconfig)

end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #
  config.vagrant.host = :detect

  #
  config.vm.box = vconfig['config']['box_type']
  config.vm.box_check_update = true

  #
  config.omnibus.chef_version = '11'

  # Hostname
  config.vm.hostname = vconfig['config']['box_name']

  # Forward Agent
  config.ssh.forward_agent = true

  # Plugin: Cachier
  config.cache.scope = :box
  config.cache.auto_detect = false
  config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ["rw", "vers=3", "udp", "fsc", "actimeo=1"]
  }
  config.cache.enable :apt
  config.cache.enable :apt_lists
  config.cache.enable :chef
  config.cache.enable :chef_gem
  config.cache.enable :composer
  config.cache.enable :gem
  config.cache.enable :npm
  config.cache.enable :generic, {
    'wget' => {cache_dir: '/var/cache/wget'},
    'curl' => {cache_dir: '/var/cache/curl'},
  }

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
  config.vm.provider 'virtualbox' do |vb|

    # Name
    vb.name = vconfig['config']['box_hostname']

    # GUI
    vb.gui = vconfig['config']['box_gui']

    # IP
    if vconfig['config']['box_dhcp'] == true
      config.vm.network 'private_network', type: 'dhcp'
    elsif vconfig['config']['box_static_ip'].length > 0
      config.vm.network :private_network, ip: vconfig['config']['box_static_ip']
    end

    # RAM and CPU
    if vconfig['config']['box_ram_cpu'] == 'auto'
      host = RbConfig::CONFIG['host_os']
      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
        memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      else
        memory = vconfig['config']['box_ram']
        cpus = vconfig['config']['box_cpu']
      end
    else
      memory = vconfig['config']['box_ram']
      cpus = vconfig['config']['box_cpu']
    end
    vb.memory = memory
    vb.cpus = cpus

    #
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']

    #
    vb.customize ['modifyvm', :id, '--ioapic', 'on']
    vb.customize ['modifyvm', :id, '--chipset', 'ich9']
    vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 0, '--nonrotational', 'on']

    #
    vb.customize ['modifyvm', :id, '--accelerate3d', 'off']

  end

  if Vagrant.has_plugin?('vagrant-hostmanager')

    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      read_ip_address(vm)
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.hostmanager.aliases = aliases

  end

  if Vagrant.has_plugin?('vagrant-persistent-storage')
    if vconfig['config']['rmdbs']['use-mysql-persistent-storage']
      config.persistent_storage.enabled = true
      config.persistent_storage.use_lvm = false
      config.persistent_storage.location = '.vagrant/storage/mysql-hdd.vdi'
      config.persistent_storage.size = 5000
      config.persistent_storage.mountname = 'mysql'
      config.persistent_storage.filesystem = 'ext4'
      config.persistent_storage.mountpoint = '/var/lib/mysql'
    end
  end

  # Provisioning
  config.vm.provision :chef_solo do |chef|

    #
    chef.environment = 'vagrant'

    #
    chef.json = vconfig

    #
    if vconfig['config']['vagrant_debugging']
      chef.arguments = '-l debug -Fdoc'
      chef.log_level = :debug
    end

    #
    chef.environments_path = 'chef-repo/environments'
    chef.cookbooks_path = [
        'chef-repo/cookbooks',
        'chef-repo/site-cookbooks'
    ]
    chef.roles_path = 'chef-repo/roles'
    chef.data_bags_path = 'chef-repo/data_bags'

    #
    chef.add_role('base')

    #
    chef.add_role('database')

    #
    chef.add_role('web')

    #
    if vconfig['config']['php']['php_version'] == '5.3'
      chef.add_role('web-php53')
    elsif vconfig['config']['php']['php_version'] == '5.4'
      chef.add_role('web-php54')
    elsif vconfig['config']['php']['php_version'] == '5.5'
      chef.add_role('web-php55')
    end

    #
    if vconfig['config']['web_tools']['web_tools_install']
      chef.add_role('web-tools')
    end

    #
    if vconfig['config']['solr']['solr_install']
      chef.add_role('solr')
    end

    #
    if vconfig['config']['varnish_install']
      chef.add_role('varnish')
    end

    #
    if vconfig['config']['testing_install']
      chef.add_role('testing')
    end

    chef.add_role('drupical')

    chef.add_role('frontend')

  end

  # restart VM
  config.vm.provision :reload

  # set post_up_message
  config.vm.post_up_message = get_vagrant_post_up_message(aliases)

  config.trigger.before :destroy do
    if File.exists?('backup/file_token')
      run_remote '/usr/local/bin/backup-db.sh'
    end
  end

end
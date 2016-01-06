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

  #
  random_ip = generate_random_ip()

  #
  box_hostname = vconfig['config']['box_hostname'].split('.')[0]

end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #
  config.vagrant.host = :detect

  #
  config.vm.box = vconfig['config']['box_type']
  config.vm.box_check_update = false
  config.vm.box_url = vconfig['config']['box_url']
  #
#  config.omnibus.chef_version = '12'

  # Hostname
  config.vm.hostname = box_hostname

  # SSH config
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # Fix NFS permission issues
  config.nfs.map_uid = Process.uid
  config.nfs.map_gid = Process.gid

  # IP
  config.vm.network :private_network, ip: random_ip

  # Plugin: Hostsupdater
  config.hostsupdater.remove_on_suspend = true
  config.hostsupdater.aliases = aliases

  # Virtualbox
  config.vm.provider 'virtualbox' do |vb|

    # Name
    vb.name = box_hostname

    # GUI
    vb.gui = vconfig['config']['box_gui']

    # RAM and CPU
    if vconfig['config']['box_ram_cpu'] == 'auto'
      host = RbConfig::CONFIG['host_os']
      if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i / 4
        memory = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
      elsif host =~ /linux/
        cpus = `nproc`.to_i / 4
        memory = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
      else
        cpus = vconfig['config']['box_cpu']
        memory = vconfig['config']['box_ram']
      end
    else
      cpus = vconfig['config']['box_cpu']
      memory = vconfig['config']['box_ram']
    end
    vb.memory = memory
    vb.cpus = cpus

    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']

    vb.customize ['modifyvm', :id, '--ioapic', 'on']
    vb.customize ['modifyvm', :id, '--chipset', 'ich9']
    vb.customize ['modifyvm', :id, '--accelerate3d', 'off']

  end

  # Synced folders
  vconfig['config']['vagrant_synced_folders'].each do |key, value|

    src = File.expand_path(value.fetch('source'))
    target = value.fetch('target')

    if (value.fetch('type') == 'nfs')

      mount_options = value.fetch('mount_options')
      mount_options.push ('clientaddr=' + random_ip)

      config.vm.synced_folder src,
                              target,
                              create: true,
                              type: "nfs",
                              mount_options: mount_options

    elsif (value.fetch('type') == 'rsync')

      config.vm.synced_folder src,
                              target,
                              type: "rsync",
                              rsync__auto: true,
                              rsync__args: [
                                  "--verbose",
                                  "--rsync-path='sudo rsync'",
                                  "--archive",
                                  "--delete",
                                  "-z"
                              ],
                              rsync__exclude: [
                                  ".git/",
                                  "vagrant/"
                              ]

    end

  end

  if vconfig['config']['rmdbs']['use-mysql-persistent-storage']
    config.persistent_storage.enabled = true
    config.persistent_storage.use_lvm = false
    config.persistent_storage.location = '.vagrant/storage/mysql-hdd.vdi'
    config.persistent_storage.size = 5000
    config.persistent_storage.mountname = 'mysql'
    config.persistent_storage.filesystem = 'ext4'
    config.persistent_storage.mountpoint = '/var/lib/mysql'
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

    #
    if vconfig['config']['solr']['solr_install']
      chef.add_role('web-solr')
    end

    #
    if vconfig['config']['varnish_install']
      chef.add_role('web-varnish')
    end

    #
    if vconfig['config']['memcached_install']
      chef.add_role('web-memcached')
    end

    #
    chef.add_role('project')

  end

  # restart VM
  config.vm.provision :reload

  # set post_up_message
  config.vm.post_up_message = get_vagrant_post_up_message(aliases)

end

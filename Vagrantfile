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
  config.omnibus.chef_version = :latest

  # SSH config
  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  # Plugin: Cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :machine
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
  end

  # hostmanager
  if Vagrant.has_plugin?('vagrant-hostmanager')

    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      read_ip_address(vm)
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

  end

  # Create base box
  config.vm.define "precise64-base", autostart: false do |base|

    #
    base.vm.box = "hashicorp/precise64"
    base.vm.box_check_update = true

    # Hostname
    base.vm.hostname = "precise64-base"

    # Network
    base.vm.network 'private_network', type: 'dhcp'

    # Set properties for provider
    base.vm.provider 'virtualbox' do |vb|

      # Name
      vb.name = "precise64-base"

      # GUI
      vb.gui = false

      #
      vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
      vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
      vb.customize ['modifyvm', :id, '--ioapic', 'on']
      vb.customize ['modifyvm', :id, '--chipset', 'ich9']
      vb.customize ['modifyvm', :id, '--accelerate3d', 'off']
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 0, '--nonrotational', 'on']

    end

    # Provisioning
    base.vm.provision :chef_solo do |chef|

      #
      chef.environment = 'vagrant'

      #
      chef.arguments = '-l debug -Fdoc'
      chef.log_level = :debug

      #
      chef.environments_path = 'chef-repo/environments'
      chef.cookbooks_path = [
          'chef-repo/cookbooks',
          'chef-repo/site-cookbooks'
      ]

      #
      chef.roles_path = 'chef-repo/roles'

      #
      chef.add_role('base')

      #
      chef.add_role('frontend')

    end

    # Restart VM
    base.vm.provision :reload

  end

  config.vm.define "precise64-base-php53", autostart: false do |php53|

    php53.vm.box = "precise64-base"

    php53.vm.hostname = "precise64-base-php53"

    php53.vm.network 'private_network', type: 'dhcp'

    # Set properties for provider
    php53.vm.provider 'virtualbox' do |vb|

      # Name
      vb.name = "precise64-base-php53"

    end

    # Provisioning
    php53.vm.provision :chef_solo do |chef|

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

      #
      chef.roles_path = 'chef-repo/roles'

      #
      chef.add_role('web')

      #
      chef.add_role('web-php53')

    end

  end

  config.vm.define "precise64-base-php54", autostart: false do |php54|

    php54.vm.box = "precise64-base"

    php54.vm.hostname = "precise64-base-php54"

    php54.vm.network 'private_network', type: 'dhcp'

    # Set properties for provider
    php54.vm.provider 'virtualbox' do |vb|

      # Name
      vb.name = "precise64-base-php54"

    end

    # Provisioning
    php54.vm.provision :chef_solo do |chef|

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

      #
      chef.roles_path = 'chef-repo/roles'

      #
      chef.add_role('web')

      #
      chef.add_role('web-php54')

    end

  end

  config.vm.define "precise64-base-php55", autostart: false do |php55|

    php55.vm.box = "precise64-base"

    php55.vm.hostname = "precise64-base-php55"

    php55.vm.network 'private_network', type: 'dhcp'

    # Set properties for provider
    php55.vm.provider 'virtualbox' do |vb|

      # Name
      vb.name = "precise64-base-php55"

    end

    # Provisioning
    php55.vm.provision :chef_solo do |chef|

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

      #
      chef.roles_path = 'chef-repo/roles'

      #
      chef.add_role('web')

      #
      chef.add_role('web-php55')

    end

  end

  config.vm.define "precise64-drupical", autostart: true do |drupical|

    if vconfig['config']['start_form'] == 'scratch'
      drupical.vm.box = "hashicorp/precise64"
    elsif vconfig['config']['start_form'] == 'base'
      drupical.vm.box = "precise64-base"
    else
      if vconfig['config']['php']['php_version'] == '5.3'
        drupical.vm.box = "precise64-base-php53"
      elsif vconfig['config']['php']['php_version'] == '5.4'
        drupical.vm.box = "precise64-base-php54"
      elsif vconfig['config']['php']['php_version'] == '5.5'
        drupical.vm.box = "precise64-base-php55"
      end
    end

    drupical.vm.box_check_update = true

    drupical.vm.hostname = "precise64-base"

    # network
    if vconfig['config']['box_dhcp'] == true
      drupical.vm.network 'private_network', type: 'dhcp'
    elsif vconfig['config']['box_static_ip'].length > 0
      drupical.vm.network :private_network, ip: vconfig['config']['box_static_ip']
    end

    if Vagrant.has_plugin?('vagrant-hostmanager')
      drupical.hostmanager.aliases = aliases
    end

    drupical.vm.provider 'virtualbox' do |vb|

      # Name
      vb.name = vconfig['config']['box_hostname']

      # GUI
      vb.gui = vconfig['config']['box_gui']

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

    end

    # Provisioning
    drupical.vm.provision :chef_solo do |chef|

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

      #
      chef.roles_path = 'chef-repo/roles'

      if vconfig['config']['start_form'] == 'scratch'

        #
        chef.add_role('base')
      end

      if vconfig['config']['start_form'] == 'scratch' or vconfig['config']['start_form'] == 'base'

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
        chef.add_role('database')

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

      #
      chef.add_role('drupical')

    end

    # Restart VM
    drupical.vm.provision :reload

    # Set post_up_message
    drupical.vm.post_up_message = get_vagrant_post_up_message(aliases)

    # Try to backup the databases
    drupical.trigger.before :destroy do
      if File.exists?('/var/enable-backup-db')
        run_remote '/usr/local/bin/backup-db.sh'
      end
    end

  end

end

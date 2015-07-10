# -*- mode: ruby -*-
# vi: set ft=ruby :

def vagrant_check_requirements

  #
  version = Vagrant::VERSION
  if(version != '1.7.1')

    puts "#"
    puts "Only Vagrant version 1.7.1 is allowed. Please install this version: http://www.vagrantup.com/download-archive/v1.7.1.html"
    puts "#"

    raise SystemExit

  end

  #
  current_dir = File.expand_path('.')
  if !File.exists? (current_dir + "/chef-repo/cookbooks/apache2")

    puts "#"
    puts "Please run following command: make install"
    puts "#"

    raise SystemExit

  end

  #
  if !Vagrant.has_plugin?("vagrant-triggers") ||
    !Vagrant.has_plugin?("vagrant-hostsupdater") ||
    !Vagrant.has_plugin?("vagrant-cachier") ||
    !Vagrant.has_plugin?("vagrant-vbguest") ||
    !Vagrant.has_plugin?("vagrant-persistent-storage") ||
    !Vagrant.has_plugin?("vagrant-hostmanager") ||
    !Vagrant.has_plugin?("vagrant-reload")

    puts "#"
    puts "Vagrant needs extra plugin(s)"
    puts "You can install them as follow:"
    puts "#"

    if !Vagrant.has_plugin?("vagrant-triggers")
      puts "vagrant plugin install vagrant-triggers"
    end

    if !Vagrant.has_plugin?("vagrant-hostsupdater")
      puts "vagrant plugin install vagrant-hostsupdater"
    end

    if !Vagrant.has_plugin?("vagrant-cachier")
      puts "vagrant plugin install vagrant-cachier"
    end

    if !Vagrant.has_plugin?("vagrant-vbguest")
      puts "vagrant plugin install vagrant-vbguest"
    end

    if !Vagrant.has_plugin?("vagrant-omnibus")
      puts "vagrant plugin install vagrant-omnibus"
    end

    if !Vagrant.has_plugin?("vagrant-persistent-storage")
      puts "vagrant plugin install vagrant-persistent-storage"
    end

    if !Vagrant.has_plugin?("vagrant-hostmanager")
      puts "vagrant plugin install vagrant-hostmanager"
    end

    if !Vagrant.has_plugin?("vagrant-reload")
      puts "vagrant plugin install vagrant-reload"
    end

    puts "#"

    raise SystemExit

  end

end

def vagrant_get_config()

  vconfig_global = false

  settings_dir = File.expand_path('.')

  if File.exists? (settings_dir + "/default.vagrant.settings.json")

    vconfig_global = JSON.parse(File.read(settings_dir + "/default.vagrant.settings.json"))

    if File.exists? (settings_dir + "/local.vagrant.settings.json")

      vconfig_local = JSON.parse(File.read(settings_dir + "/local.vagrant.settings.json"))

      vconfig_global = vconfig_global.deep_merge(vconfig_local)

    else

      puts "#"
      puts "Couldn't find local.vagrant.settings.json in " + settings_dir + "."
      puts "#"

      raise SystemExit

    end

    vconfig_global['config']['vhosts'].each do |key, vhost|
      if vhost['server_name'].include? "_"

        puts "#"
        puts "Vhost aliasses cannot contain underscores."
        puts "#"

        raise SystemExit

      end
    end

    if vconfig_global['config']['box_hostname'].include? "_"

      puts "#"
      puts "Box hostname cannot contain underscores."
      puts "#"

      raise SystemExit

    end

  else

    puts "#"
    puts "Couldn't find default.vagrant.settings.json in " + settings_dir + "."
    puts "#"

    raise SystemExit

  end

  return vconfig_global

end

def vagrant_get_aliases(vconfig)

  #
  aliases = Array.new

  #
  vhosts = vconfig['config']['vhosts']
  vhosts.each do |key, vhost|

    aliases.push(vhost.fetch('server_name'))

    vhost['aliases'].each do |_alias|
      if _alias.include?("_")
        _alias = _alias.gsub!("_","-")
      end
      aliases.push(_alias)
    end

  end

  #
  if vconfig['config']['web_tools']['web_tools_install']

    vconfig['config']['web_tools']['tools'].each do |key, web_tool|
      if web_tool['install']
        url_base = vconfig['config']['web_tools']['url_base']
        tool_alias = web_tool.fetch('alias')
        aliases.push("#{tool_alias}.#{url_base}")
      end
    end

  end

  return aliases

end

def read_ip_address(ip)

  return ip

end

def generate_random_ip()

  file_random_ip = File.expand_path('.') + "/.vagrant/random_ip"

  if File.exists? (file_random_ip)
    ip = File.read(file_random_ip)
  else
    ip = "192.168.#{rand(252)+1}.#{rand(252)+1}"
    File.open(file_random_ip, 'w') {
      |f| f.write(ip)
    }
  end

  return ip

end

class Hash

  def deep_merge(hash)

    target = dup

    hash.keys.each do |key|
      if hash[key].is_a? Hash and self[key].is_a? Hash
        target[key] = target[key].deep_merge(hash[key])
        next
      end

      target[key] = hash[key]
    end

    target

  end

end


def get_vagrant_post_up_message(aliases)
  message = aliases.to_s
end

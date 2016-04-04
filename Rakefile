# -*- mode: ruby -*-
# vi: set ft=ruby :

desc "default=up"
task :default do

  Rake::Task["core:up"].invoke()

end

namespace :core do

  desc "up"
  task :up do
    puts "up"
    begin
      sh "ssh-add -K ~/.ssh/id_rsa && vagrant up && vagrant ssh"
    rescue
    end
  end

  desc "halt"
  task :halt do
    begin
      sh "vagrant halt"
    rescue
    end
  end

  desc "suspend"
  task :suspend do
    begin
      sh "vagrant suspend"
    rescue
    end
  end

  desc "reload"
  task :reload do
    begin
      sh "vagrant reload"
    rescue
    end
  end

  desc "up_rsync"
  task :up_rsync do
    begin
      sh "ssh-add -K ~/.ssh/id_rsa && vagrant up"
      sh "vagrant rsync-auto"
    rescue
    end
  end

  desc "ssh"
  task :ssh do
    begin
      sh "vagrant ssh"
    rescue
    end
  end

  desc "destroy"
  task :destroy do
    begin
      sh "vagrant destroy -f"
    rescue
    end
  end

end

namespace :share do

  desc "web"
  task :web do
    sh "vagrant login && vagrant share --http 80 --https 443"
  end

  desc "ssh"
  task :ssh do
    sh "vagrant login && vagrant share --ssh"
  end

  desc "all"
  task :full do
    sh "vagrant login && vagrant share --http 80 --https 443 --ssh"
  end

end

namespace :environment do

  desc "install vagrant dependencies"
  task :install_dependencies_vagrant do
    sh "vagrant plugin install vagrant-cachier --plugin-version '1.2.0'"
    sh "vagrant plugin install vagrant-hostsupdater --plugin-version '0.0.11'"
    sh "vagrant plugin install vagrant-omnibus --plugin-version '1.4.1'"
    sh "vagrant plugin install vagrant-persistent-storage --plugin-version '0.0.16'"
    sh "vagrant plugin install vagrant-reload --plugin-version '0.0.1'"
    sh "vagrant plugin install vagrant-share --plugin-version '1.1.4'"
    sh "vagrant plugin install vagrant-triggers --plugin-version '0.5.0'"
    sh "vagrant plugin install vagrant-vbguest --plugin-version '0.10.0'"
  end

end

namespace :maintenance do

  desc "clear_logs"
  task :clear_logs do
    Rake::Task["core:up"].invoke()
    sh "vagrant ssh --command 'sudo rm -rf /var/log/*'"
    sh "vagrant ssh --command 'sudo mkdir /var/log/apache2 ; sudo mkdir /var/log/mysql'"
    Rake::Task["core:reload"].invoke()
  end

  desc "restart_apache"
  task :restart_apache do
    sh "vagrant ssh --command 'sudo service apache restart'"
  end

  desc "restart_mysql"
  task :restart_mysql do
    sh "vagrant ssh --command 'sudo service mysql restart'"
  end

  desc "shrink"
  task :shrink do

    begin
      require 'json'
      load 'include/helper.rb'
      vconfig = vagrant_get_config()
      box_hostname = vconfig['config']['box_hostname'].split('.')[0]
    rescue
      LoadError
    end

    Rake::Task["core:up"].invoke()

    Rake::Task["maintenance:clear_logs"].invoke()

    begin
      sh "vagrant ssh --command 'sudo cat /dev/zero > zero.fill'"
    rescue
      sh "vagrant ssh --command 'sudo sync;sleep 1;sudo sync;'"
      sh "vagrant ssh --command 'sudo rm -f zero.fill'"
    end

    begin
      Rake::Task["core:halt"].invoke()
      sh "tar -cvzf ~/VirtualBox\\ VMs/"+ box_hostname + ".tar.gz ~/VirtualBox\\ VMs/"+ box_hostname
      Rake::Task["core:up"].invoke()
      sh "VBoxManage storageattach " + box_hostname + " --storagectl SATAController --port 0 --device 0 --type hdd --medium none"
      sh "VBoxManage clonehd --format VDI ~/VirtualBox\\ VMs/"+ box_hostname +"/box-disk1.vmdk /tmp/box-disk1.vdi"
      sh "VBoxManage closemedium disk ~/VirtualBox\\ VMs/"+ box_hostname +"/box-disk1.vmdk --delete"
      sh "VBoxManage modifyhd /tmp/box-disk1.vdi --compact"
      sh "VBoxManage clonehd --format vmdk /tmp/box-disk1.vdi ~/VirtualBox\\ VMs/"+ box_hostname +"/box-disk1.vmdk"
      sh "VBoxManage closemedium disk /tmp/box-disk1.vdi --delete"
      sh "VBoxManage storageattach " + box_hostname + " --storagectl SATAController --port 0 --device 0 --type hdd --medium ~/VirtualBox\\ VMs/"+ box_hostname +"/box-disk1.vmdk"
      sh "rm -rf ~/VirtualBox\\ VMs/"+ box_hostname + ".tar.gz"
    rescue
      Rake::Task["core:halt"].invoke()
      sh "tar -xvzf ~/VirtualBox\\ VMs/"+ box_hostname + ".tar.gz ~/VirtualBox\\ VMs/"+ box_hostname
    end

    Rake::Task["core:reload"].invoke()

  end

end

namespace :emergency_fix do

  desc "nfs"
  task :nfs do

    Rake::Task["core:halt"].invoke()

    begin
      sh "sudo rm -f /etc/exports"
    rescue
    end

    begin
      for i in 0..20
        sh "vboxmanage hostonlyif remove vboxnet#{i}"
      end
    rescue
    end

    Rake::Task["core:up"].invoke()

    begin
      sh "vagrant hostsupdater"
    rescue
    end

  end

  desc "forcekill"
  task :forcekill do

    begin
      begin
        sh "sudo killall -9 vagrant"
      rescue
      end
      begin
        sh "sudo killall -9 VBoxHeadless"
      rescue
      end
      begin
        sh "sudo killall -9 ruby"
      rescue
      end
    rescue
    end

  end

end
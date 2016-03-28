# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.define "basic" do |basic|
    basic.vm.box="nrel/CentOS-6.5-x86_64"
    basic.vm.hostname="basic-box"
    basic.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.define "modified" do |modified|
    modified.vm.box="ubuntu/trusty64"
    modified.vm.hostname="modified-box"
    modified.vm.network "private_network", ip: "192.168.33.20"
    modified.vm.provider "virtualbox" do |vb|
      file_to_disk = File.realpath( "." ).to_s + "/disk.vdi"
      if ARGV[0] == "up" && ! File.exist?(file_to_disk) 
        vb.customize [
          'createhd', 
          '--filename', file_to_disk, 
          '--format', 'VDI', 
          '--size', 2 * 1024
           ]
      end                
        vb.customize [
          'storageattach', :id, 
          '--storagectl', 'SATAController', 
          '--port', 1, '--device', 0, 
          '--type', 'hdd', '--medium', 
          file_to_disk
          ]  
    modified.vm.provision :shell, path: "mount.sh"
    end
    modified.vm.provision :ansible do |ansible|
      ansible.playbook="box.yml" 
    end
  end

end

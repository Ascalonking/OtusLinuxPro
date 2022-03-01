# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.box_version = "2004.01"

  config.vm.provider "virtualbox" do |v|
	  v.memory = 256
	  v.cpus = 1
  end

  config.vm.define "rpms" do |rpms|
	  rpms.vm.network "private_network", ip: "192.168.50.10",
  virtualbox__intnet: "net1"
	  rpms.vm.hostname = "rpms"
    rpms.vm.provision "shell", path: "rpm.sh"
  end
end

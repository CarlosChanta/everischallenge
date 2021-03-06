# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rbconfig'
require 'yaml'

cpuCap = 15                                
inventory = YAML.load_file("inventarioVMs.yml")
DEFAULT_BOX = "centos/7"

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  inventory.each do |group, groupHosts|
    next if (group == "justLocal")
    groupHosts['hosts'].each do |hostName, hostInfo|
      config.vm.define hostName do |node|
        node.vm.box = hostInfo['box'] ||= DEFAULT_BOX
        node.vm.hostname = hostName                                       # NOMBRE HOST
        node.vm.network :private_network, ip: hostInfo['ansible_host']    # IP DE LA VM
        node.vm.network "forwarded_port", host: hostInfo['hnum'], guest: hostInfo['hguest']
        ram = hostInfo['memory']                                          # RAM DE LA VM
        node.vm.provider :virtualbox do |vb|
          vb.cpus = 1
          vb.gui = false
          vb.name = hostName
          vb.customize ["modifyvm", :id, "--cpuexecutioncap", cpuCap, "--memory", ram.to_s]
        end
      end
    end
  end
  config.vm.provision "ansible", run:"always" do |ansible|
    ansible.playbook= "site.yml"
  end
end

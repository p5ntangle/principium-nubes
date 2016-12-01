#-*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

nodes = YAML.load_file('nodes.yml')
hosts = ""
ip = {}
box = {}
nodes.each do |node|
  hosts = hosts + "#{node['ip']} #{node['name']}\n"
end


Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo \"#{hosts}\" >> /etc/hosts"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
  end
  nodes.each do |node|
    config.vm.define "#{node['name']}" do |inst|
      inst.vm.box = node['box']
      # inst.vm.hostname = node['name']
      config.vm.provision :shell, inline: "hostnamectl set-hostname #{node['name']}"
      inst.vm.network "private_network", ip: node['ip']
      inst.vm.provision "shell", path: "provision/#{node['name']}.sh"
      config.ssh.private_key_path = "./keys/id_rsa"
    end
  end
end

      #config.vm.provision "shell", path: "provision/#{node['name']}.sh"

config.vm.box = "precise64"
config.vm.box_url = "http://files.vagrantup.com/precise64.box"
config.vm.network :forwarded_port, guest: 80, host: 8080
config.vm.network :private_network, ip: "172.16.0.2"
config.vm.provider :virtualbox do |vb|
  # boot with headless mode
  vb.gui = false

  # Use VBoxManage to customize the VM. For example to change memory:
  vb.customize ["modifyvm", :id, "--memory", "2048"]
end
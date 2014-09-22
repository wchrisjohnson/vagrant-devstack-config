# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "puphpet/ubuntu1404-x64"
  config.vm.hostname = "trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "forwarded_port", guest: 3333, host: 3333
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8004, host: 8004
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8773, host: 8773
  config.vm.network "forwarded_port", guest: 8774, host: 8774
  config.vm.network "forwarded_port", guest: 8776, host: 8776
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.network "forwarded_port", guest: 9696, host: 9696
  config.vm.network "forwarded_port", guest: 35357, host: 35357

  config.vm.network "private_network", ip: "172.16.0.2", auto_config: true
  config.vm.network "private_network", ip: "172.16.10.2", auto_config: true

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = "2"
    v.vmx["vhv.enable"] = "TRUE"
  end

  # Create local.conf file and push it to vm
  config.vm.provision :ansible do |ansible|
    ansible.verbose = true
    ansible.playbook = "ansible/devstack.yml"
    ansible.limit = 'all'
  end

  # do the provision via shell vs ansible so we
  # can watch the progress.
  config.vm.provision :shell, :path => "ansible/bootstrap.sh", :privileged => false

  # # create nic#2 (eth1)
  # config.vm.provision :shell, :path => "ansible/add_eth1.sh", :privileged => false

  # Create a keypair, add it to devstack
  config.vm.provision :ansible do |ansible|
    ansible.verbose = true
    ansible.playbook = "ansible/keypair.yml"
    ansible.limit = 'all'
  end

  # Setup DNS and open ports
  config.vm.provision :shell, :path => "ansible/finalize.sh", :privileged => false

end
